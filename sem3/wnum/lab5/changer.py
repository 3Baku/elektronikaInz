from pypdf import PdfReader, PdfWriter

def extract_single_page(source_path, output_path, page_number):
    """
    Wycina jedną stronę z PDF i zapisuje do nowego pliku.
    
    :param source_path: Ścieżka do pliku źródłowego
    :param output_path: Ścieżka do pliku wynikowego
    :param page_number: Numer strony (liczony naturalnie, od 1)
    """
    try:
        reader = PdfReader(source_path)
        writer = PdfWriter()

        # Sprawdzamy, czy strona istnieje
        # Odejmujemy 1, aby zamienić numer strony na indeks (0-based)
        page_index = page_number - 1
        
        if 0 <= page_index < len(reader.pages):
            # Pobranie konkretnej strony
            page = reader.pages[page_index]
            
            # Dodanie strony do nowego obiektu PDF
            writer.add_page(page)

            # Zapisanie wyniku
            with open(output_path, "wb") as output_file:
                writer.write(output_file)
            
            print(f"Sukces! Strona {page_number} została zapisana jako '{output_path}'.")
        else:
            print(f"Błąd: PDF ma tylko {len(reader.pages)} stron. Nie można wyciąć strony {page_number}.")

    except FileNotFoundError:
        print("Błąd: Nie znaleziono pliku źródłowego.")

# --- PRZYKŁAD UŻYCIA ---
# Chcemy wyciąć 3. stronę z pliku "zad.pdf"
extract_single_page("zad.pdf", "wycieta_strona.pdf", 1)