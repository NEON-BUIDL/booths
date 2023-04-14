#!/bin/bash

# Function to process files
process_files() {
    local dir="$1"
    local filetype="$2"
    local output_type="$3"
    local output_width="$4"
    local output_height="$5"

    # Loop through all files of given filetype in the directory
    for file in $(find "$dir" -type f -iname "*.$filetype"); do
        local base_filename=$(basename "$file" .$filetype)
	local skip_gif=false skip_png=false

	[[ -f "$dir/$base_filename.gif" ]] && skip_gif=true
	[[ -f "$dir/$base_filename.png" ]] && skip_png=true


        # Process gif files
        if [[ $output_type == "gif" || $output_type == "both" ]]; then
	  if [[ $skip_gif == false ]]; then
            for i in {0..5}; do
                local yaw=$((i * 45 % 315))
                local filename="$base_filename-$i.png"
                screenshot-glb -i "$file" -w 512 -h 512 -m "orientation=0 0 $yaw" -o "$filename"
            done

            montage "$base_filename"-*.png -tile 6x1 -geometry +0+0 -background none -resize 3072x512 "montage-$base_filename.png"
            convert -dispose background -delay 50 -loop 0 "$base_filename"-*.png "$dir"/"$base_filename.gif"
            rm "$base_filename"-*.png
        fi

        # Process png files
        if [[ $output_type == "png" || $output_type == "both" ]]; then
	  if [[ $skip_png == false ]]; then
            screenshot-glb -i "$file" -w "$output_width" -h "$output_height" -m "orientation=0 0 180" -o "$dir"/"$base_filename.png"
        fi
      fi
    fi
    done
}

# Function to generate HTML gallery
generate_html_gallery() {
    local dir="$1"
    local filetype="$2"

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
    find "$dir" -type f -name "*.$output_type" | while read -r file; do
        local glb_file="${file%.*}.glb"
        echo "  <a href=\"$glb_file\"><img src=\"$file\"></a>"
    done
    echo "</div>"
    echo "</body>"
    echo "</html>"
}

# Main function
main() {
    local dir="$1"
    local filetype="$2"
    local output_type="png"
    local output_width=512
    local output_height=512

    process_files "$dir" "$filetype" "$output_type" "$output_width" "$output_height"
    generate_html_gallery "$dir" "$filetype"
}


main "$@"

