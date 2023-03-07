#!/bin/bash

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
for gif_file in *.gif
do
  glb_file="${gif_file%.*}.glb"
  echo "  <a href=\"$glb_file\"><img src=\"$gif_file\"></a>"
done
echo "</div>"
echo "</body>"
echo "</html>"
