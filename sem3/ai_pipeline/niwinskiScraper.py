#studia.elka.pw.edu.pl/f-raw/25Z/103A-ELxxx-ISP-PROS/lim//w1/wyklad_1.html
import requests
from bs4 import BeautifulSoup
from markdownify import markdownify as md

def scrape_url_to_markdown(url, output_file="output.md"):
    try:
        # 1. Define headers to look like a real browser (avoids being blocked)
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
        }

        # 2. Fetch the HTML content
        print(f"Fetching {url}...")
        response = requests.get(url, headers=headers)
        response.raise_for_status()  # Check for HTTP errors

        # 3. Parse HTML with BeautifulSoup to clean it up
        soup = BeautifulSoup(response.content, 'html.parser')

        # Remove unwanted tags (scripts, styles, metadata, etc.)
        for tag in soup(["script", "style", "meta", "noscript", "head", "input", "form"]):
            tag.decompose()

        # Optional: specific cleanup for headers/footers if you know the class names
        # for div in soup.find_all("div", class_=["header", "footer", "nav"]):
        #     div.decompose()

        # 4. Convert the cleaned HTML to Markdown
        # heading_style="ATX" ensures headings use # instead of underlining
        markdown_content = md(str(soup), heading_style="ATX")

        # 5. Save to file
        with open(output_file, "w", encoding="utf-8") as f:
            f.write(markdown_content)
        
        print(f"Success! Content saved to {output_file}")

    except requests.exceptions.RequestException as e:
        print(f"Error fetching the URL: {e}")
    except Exception as e:
        print(f"An error occurred: {e}")

# --- USAGE ---
if __name__ == "__main__":
    target_url = "https://studia.elka.pw.edu.pl/f-raw/25Z/103A-ELxxx-ISP-PROS/lim//w1/wyklad_1.html"
  #  target_url = input("Enter the URL to scrape: ")
    scrape_url_to_markdown(target_url, "scraped_site.md")