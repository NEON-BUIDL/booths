#!/bin/bash

# Check for the directory argument
if [ $# -eq 0 ]; then
  echo "Please provide a directory as an argument."
  exit 1
fi

directory=$1

# Ask the user for the preferred thumbnail file type
read -p "Enter the preferred thumbnail file type (gif or png): " file_type

# Validate user input
if [[ "$file_type" != "gif" ]] && [[ "$file_type" != "png" ]]; then
  echo "Invalid file type. Please choose 'gif' or 'png'."
  exit 1
fi

# Generate HTML gallery
echo "<!DOCTYPE html>"
echo "<html>"
echo "<head>"
echo "<meta charset=\"UTF-8\">"
echo "<title>Image Gallery</title>"
echo "<style>"
echo "  .gallery {"
echo "    display: grid;"
echo "    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));"
echo "    grid-gap: 10px;"
echo "  }"
echo "  .gallery img {"
echo "    width: 100%;"
echo "    height: 100%;"
echo "    object-fit: cover;"
echo "  }"
echo "</style>"
echo "</head>"
echo "<body>"
echo "<div class=\"gallery\">"
find "$directory" -type f -name "*.$file_type" | while read -r file
do
  glb_file="${file%.*}.glb"
  echo "  <a href=\"$glb_file\"><img src=\"$file\"></a>"
done
echo "</div>"
echo "</body>"
echo "</html>"
