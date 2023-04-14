#!/bin/bash

dir="$1"
output_type="$2"

echo "| Preview | GLB |"
echo "| ------- | --- |"

# Loop through all files of given filetype in the directory
while IFS= read -r -d '' png; do
    base="$(basename "$png" .png)"
    glb="$(find "$dir" -type f -iname "$base.glb" -print -quit)"
    [[ -n "$glb" ]] && echo "| ![$base]($png) | [$base.glb]($glb) |"
done < <(find "$dir" -type f -iname "*.png" -print0)
