import os

class MarkdownReportGenerator:
    """Handles saving text content to a Markdown file."""

    def __init__(self, output_filename="gemini_output.md"):
        """Initializes the report generator.

        Args:
            output_filename (str): The desired name for the output file.
                                   Defaults to "gemini_output.md".
        """
        self.output_filename = output_filename

    def save_to_markdown(self, text_content: str):
        """Saves text string into a formatted Markdown file (UTF-8).

        Args:
            text_content (str): The text to write to the file.
        """
        try:
            with open(self.output_filename, "w", encoding="utf-8") as f:
                f.write(text_content)
            
            print(f"Report saved successfully to {self.output_filename}")
            
        except Exception as e:
            print(f"Error saving file: {e}")