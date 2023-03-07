#!/bin/bash

# Generate thumbnail images
for glb_file in *.glb
do
  png_file="${glb_file%.*}.png"
  if [ ! -f "$png_file" ]
  then
    convert -define png:exclude-chunks=date,time -thumbnail x200 -background white -gravity center -extent 200x200 "$glb_file" "$png_file"
  fi
done

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
for png_file in *.png
do
  glb_file="${png_file%.*}.glb"
  echo "  <a href=\"$glb_file\">$glb_file</a>"
done
echo "</div>"
echo "</body>"
echo "</html>"
