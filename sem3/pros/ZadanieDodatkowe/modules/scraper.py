import os
from typing import List, Optional
from urllib.parse import urljoin

import requests
from bs4 import BeautifulSoup


class PDFScraper:
    """Handles scraping websites for PDF links and downloading them."""

    def __init__(self, download_folder: str = 'downloads') -> None:
        """Initializes the scraper with a specific download directory.

        Args:
            download_folder (str): The name of the folder to save downloads.
                Defaults to 'downloads'.
        """
        self.download_folder = download_folder
        if not os.path.exists(download_folder):
            os.makedirs(download_folder)

    def find_pdf_by_name(self, url: str, link_text: str) -> Optional[str]:
        """Scrapes a URL for a specific link text and returns the full PDF URL.

        Args:
            url (str): The target website URL to scrape.
            link_text (str): The text content of the link to search for.

        Returns:
            str or None: The full URL of the PDF if found, otherwise None.
        """
        try:
            print(f"Connecting to {url}...")
            response = requests.get(url, verify=True)
            response.raise_for_status()
            soup = BeautifulSoup(response.text, 'html.parser')

            for a_tag in soup.find_all('a', href=True):
                if link_text.lower() in a_tag.get_text(strip=True).lower():
                    href = a_tag['href']
                    full_url = urljoin(url, href)
                    print(
                        f"Found match: '{a_tag.get_text(strip=True)}' "
                        f"-> {full_url}"
                    )
                    return full_url

            print(f"Could not find link with text: '{link_text}'")
            return None

        except Exception as e:
            print(f"Error scraping {url}: {e}")
            return None
        
    def download_pdf(self, pdf_url: str) -> Optional[str]:
        """Downloads a single PDF and returns the local file path.

        Args:
            pdf_url (str): The full URL of the PDF to download.

        Returns:
            str or None: The local file path if successful, otherwise None.
        """
        try:
            if not pdf_url:
                return None

            local_filename = pdf_url.split('/')[-1]

            if '?' in local_filename:
                local_filename = local_filename.split('?')[0]

            path = os.path.join(self.download_folder, local_filename)

            print(f"Downloading {pdf_url}...")
            with requests.get(pdf_url, stream=True) as r:
                r.raise_for_status()
                with open(path, 'wb') as f:
                    for chunk in r.iter_content(chunk_size=8192):
                        f.write(chunk)

            return path
        except Exception as e:
            print(f"Failed to download {pdf_url}: {e}")
            return None