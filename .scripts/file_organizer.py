import os
import shutil
import argparse

# Current user home dir.
HOME_DIR = os.path.expanduser("~")

DIRECTORIES_TO_SCAN = [ HOME_DIR, os.path.join(HOME_DIR, "Downloads")]

# Directories where to move files.
images = "Images"
documents = "Documents"
music = "Music"
videos = "Videos"

EXTENSION_DIR_MAP = {
    ".jpg": images,
    ".png": images,
    ".gif": images,
    ".pdf": documents,
    ".mp3": music,
    ".mp4": videos
}

PREVIEW_SIZE_LIMIT = 500

DIRECTORIES_TO_IGNORE = [
    "code", # Own git repos
    "Backup",
    "Games",
    "Notes"
]

def should_ignore(item):
    return item.startswith('.') or item in DIRECTORIES_TO_IGNORE

def get_user_action(file_path):
    print(f"File: {file_path}")
    action = input("What would you like to do? (m: move, d: delete, s: skip): ").strip().lower()
    return action

def print_file_preview(file_path):
    if os.path.getsize(file_path) > PREVIEW_SIZE_LIMIT:
        print("No preview, file too big")
    elif os.path.getsize(file_path) == 0:
        print("No preview, empty file")
    else:
        with open(file_path, 'r', errors='ignore') as file:
            content = file.read(PREVIEW_SIZE_LIMIT)
            print(f"Preview:\n{content}\n")

def organize_file(file_path, dest_dir):
    destination_path = os.path.join(HOME_DIR, dest_dir)
    os.makedirs(destination_path, exist_ok=True)
    shutil.move(file_path, destination_path)
    print(f"Moved {file_path} to {destination_path}")

def main():
    for directory in DIRECTORIES_TO_SCAN:
        for root, dirs, files in os.walk(directory):
            dirs[:] = [d for d in dirs if not should_ignore(d)]
            for file in files:
                if should_ignore(file):
                    print(f"Automatically skipping file: {file}")
                    continue
                file_path = os.path.join(root, file)
                _, extension = os.path.splitext(file_path)
                dest_dir = EXTENSION_DIR_MAP.get(extension)
                print_file_preview(file_path)
                action = get_user_action(file_path)
                if action == 'm':
                    organize_file(file_path, dest_dir)
                elif action == 'd':
                    os.remove(file_path)
                    print(f"Deleted {file_path}")
                elif action == 's':
                    print(f"Skipped {file_path}")
                else:
                    print("Invalid action. Skipping file")


if __name__ == "__main__":
    main()
