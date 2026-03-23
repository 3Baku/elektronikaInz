import os
import sys

from dotenv import load_dotenv

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from modules.ai_client import GeminiClient
from modules.markdown_writer import MarkdownReportGenerator
from modules.scraper import PDFScraper

TARGET_URL = "https://www.imio.pw.edu.pl/index.php/studia/dyplomowanie"
LINK_TEXT_TO_FIND = "pytania na egzamin dyplomowy inżynierski"


def get_local_file():
    """Prompts the user for a valid local file path.

    Returns:
        str or None: The valid file path, or None if the user quits.
    """
    while True:
        path = input(
            "Enter full path to your local file (or 'q' to cancel): "
        ).strip()
        if path.lower() == 'q':
            return None

        path = path.replace('"', '').replace("'", "")

        if os.path.exists(path):
            return path
        else:
            print("File not found. Try again.")


def main():
    """Main execution function for the PDF analysis tool."""
    load_dotenv()
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        print("Error: GEMINI_API_KEY missing.")
        return

    scraper = PDFScraper()
    ai_bot = GeminiClient(api_key)

    files_to_process = []

    print("--- Step 1: Scraping ---")
    print(f"Looking for '{LINK_TEXT_TO_FIND}'...")
    pdf_url = scraper.find_pdf_by_name(TARGET_URL, LINK_TEXT_TO_FIND)

    if pdf_url:
        local_path = scraper.download_pdf(pdf_url)
        if local_path:
            files_to_process.append(local_path)
            print("Main scraped PDF added to queue.")
    else:
        print("Warning: Main PDF not found. You can still add local files.")

    while True:
        print(f"\nCurrent Queue: {len(files_to_process)} file(s).")
        choice = input(
            "Do you want to add another file? "
            "(1: Add Local File, 2: Done): "
        ).strip()

        if choice == '1':
            new_file = get_local_file()
            if new_file:
                files_to_process.append(new_file)
                print(f"Added: {os.path.basename(new_file)}")
        elif choice == '2':
            break
        else:
            print("Invalid choice.")

    if not files_to_process:
        print("No files to process. Exiting.")
        return

    user_instruction = input("\nNa które pytanie mam odpowiedzieć? ")

    default_prefix = (
        "INSTRUKCJE: Pierwszy dostarczony plik (o nazwie 'pytania_egzamin_inzynierski') to zbiór pytań z dyplomowania, na kóre masz odpowiadać."
        "Odpowiadaj w języku polskim."
        "Wszystkie kolejne pliki są kontekstem."
        "Użyj kontekstu, aby odpowiedzieć na wybrane pytania zadeklarowane przez użytkownika ze zbioru pytań."
        "Jeżeli nie zostaniesz poproszony inaczej, to Twoje odpowiedzi mają być zwięzłe i treściwe."
        "Odpowiedź będzie zapisana w pliku markdown, więc odpowiadaj z dogodnym formatowaniem."
        f"Pytanie użytkowanika: {user_instruction}."
    )

    ai_response = ai_bot.analyze_files(files_to_process, default_prefix)

    output_name = "Gemini_MultiFile_Analysis.md"

    md_writer = MarkdownReportGenerator(output_filename=output_name)
    md_writer.save_to_markdown(ai_response)

    print(f"Saved analysis to {output_name}")


if __name__ == "__main__":
    main()