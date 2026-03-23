import time
from typing import List
from google import genai


class GeminiClient:
    """A client for interacting with the Google Gemini API."""

    def __init__(self, api_key: str):
        """Initializes the Gemini client.

        Args:
            api_key (str): The Google GenAI API key.
        """
        self.client = genai.Client(api_key=api_key)
        self.model_name = "gemini-2.5-flash"

    def upload_file(self, file_path: str):
        """Uploads a file to Gemini and waits for processing to complete.

        Args:
            file_path (str): The local path to the file.

        Returns:
            google.genai.types.File: The metadata of the processed file.

        Raises:
            ValueError: If file processing fails remotely.
        """
        print(f"Uploading {file_path} to Gemini...")

        uploaded_file = self.client.files.upload(file=file_path)
        print(f"Upload complete. File URI: {uploaded_file.uri}")

        while True:
            file_metadata = self.client.files.get(name=uploaded_file.name)

            if file_metadata.state == "ACTIVE":
                print("File processed and ready.")
                return file_metadata
            elif file_metadata.state == "FAILED":
                raise ValueError("File processing failed on Gemini side.")

            print("Processing file remotely...")
            time.sleep(2)
    def analyze_files(self, file_path_list: List[str], prompt: str) -> str:
            """Uploads a list of files and queries the model using those files.

            Args:
                file_path_list (List[str]): A list of local file paths to be uploaded.
                prompt (str): The text prompt or question to send to the model.

            Returns:
                str: The complete generated text response from the model, or an
                    error message string if the process fails.
            """
            uploaded_objs = []
            full_response_text = ""

            try:
                print(f"--- Preparing {len(file_path_list)} file(s) ---")
                for path in file_path_list:
                    file_obj = self.upload_file(path)
                    uploaded_objs.append(file_obj)

                print(
                    f"Sending prompt with {len(uploaded_objs)} file(s) to "
                    f"{self.model_name}..."
                )

                response_stream = self.client.models.generate_content_stream(
                    model=self.model_name,
                    contents=[*uploaded_objs, prompt]
                )

                print("Generating response (this may take a moment)...")

                for chunk in response_stream:
                    if chunk.text:
                        full_response_text += chunk.text

                print("Response generated successfully.")
                return full_response_text

            except Exception as e:
                return f"\nAI Generation Error: {e}"

            finally:
                print("Cleaning up remote files...")
                for f in uploaded_objs:
                    try:
                        self.client.files.delete(name=f.name)
                    except Exception as cleanup_err:
                        print(f"Warning: Could not delete {f.name}: {cleanup_err}")