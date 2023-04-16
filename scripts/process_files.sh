#!/bin/bash

# Function to process files
process_files() {
    # Check for required arguments
    if [[ $# -ne 5 ]]; then
        echo "Usage: $0 directory filetype output_type output_width output_height"
        exit 1
    fi

    local dir="$1"
    local filetype="$2"
    local output_type="$3"
    local output_width="$4"
    local output_height="$5"

    # Loop through all files of given filetype in the directory
    find "$dir" -type f -name "*.$filetype" -print0 | while IFS= read -r -d '' file; do
        echo "Processing $file..."
        local base_filename=$(basename "$file" ".$filetype")
        local skip_gif=false skip_png=false

        # Store the directory path of the current file
        local output_dir=$(dirname "$file")

        [[ -f "$output_dir/$base_filename.gif" ]] && skip_gif=true
        [[ -f "$output_dir/$base_filename.png" ]] && skip_png=true

        # Process gif files
        if [[ $output_type == "gif" || $output_type == "both" ]]; then
            if [[ $skip_gif == false ]]; then
                for i in {0..5}; do
                    local yaw=$((i 45 % 315))
                    local filename="$base_filename-$i.png"
                    node ./node_modules/.bin/screenshot-glb -i "$file" -w 512 -h 512 -m "orientation=0 0 $yaw" -o "$output_dir/$filename"
                done

                montage "$output_dir/$base_filename"-*.png -tile 6x1 -geometry +0+0 -background none -resize 3072x512 "$output_dir/montage-$base_filename.png"
                convert -dispose background -delay 50 -loop 0 "$output_dir/$base_filename"-*.png "$output_dir/$base_filename.gif"
                rm "$output_dir/$base_filename"-*.png
            fi
        fi

        # Process png files
        if [[ $output_type == "png" || $output_type == "both" ]]; then
            if [[ $skip_png == false ]]; then
                node ./node_modules/.bin/screenshot-glb -i "$file" -w "$output_width" -h "$output_height" -m "orientation=0 0 180" -o "$output_dir/$base_filename.png"
            fi
        fi
    done
}

# Call process_files function with command line arguments
process_files "$@"
