#!/bin/bash

# Check if a file argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Check if the input file exists
if [ ! -f "$1" ]; then
    echo "Error: File '$1' does not exist."
    exit 1
fi

input_file="$1"
temp_file="${input_file%.*}_temp.mp4"

# Convert the file using ffmpeg
if ! ffmpeg -i "$input_file" -c:v libx264 -c:a copy "$temp_file"; then
    echo "Error: Conversion failed."
    exit 1
fi

# Remove the original file
if ! rm "$input_file"; then
    echo "Error: Could not remove original file."
    exit 1
fi

# Rename the temporary file to the original filename
if ! mv "$temp_file" "$input_file"; then
    echo "Error: Could not rename temporary file."
    exit 1
fi

echo "Conversion successful: '$input_file'"
