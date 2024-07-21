from googleapiclient.discovery import build
from google.oauth2 import service_account

SCOPES = ['https://www.googleapis.com/auth/drive']
SERVICE_ACCOUNT_FILE = 'service_account.json'
PARENT_FOLDER_ID = "1RXzDGO0ycDelT3t1eHbfgyOguWOhzuMk"

def authenticate():
    creds = service_account.Credentials.from_service_account_file(SERVICE_ACCOUNT_FILE, scopes=SCOPES)
    return creds

def upload_photo(file_path):
    creds = authenticate()
    service = build('drive', 'v3', credentials=creds)
    file_metadata = {
        'name': "floor",
        'parents': [PARENT_FOLDER_ID]
    }
    file = service.files().create(
        body=file_metadata,
        media_body=file_path
    ).execute()

    # Get the file ID
    file_id = file['id']

    # Construct the URL
    image_url = f"https://drive.google.com/uc?export=view&id={file_id}"
    return image_url

# Example usage
image_url = upload_photo("floorplan.png")
print(f"Image URL: {image_url}")
