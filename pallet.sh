#!/bin/bash

process_files() {
    local dir="$1"
    local filetype="$2"
    local output_type="$3"
    local output_width="$4"
    local output_height="$5"

    for file in $(find "$dir" -type f -iname "*.$filetype"); do
        local base_filename=$(basename "$file" .$filetype)
        
        if [[ $output_type == "gif" || $output_type == "both" ]]; then
            for i in {0..5}; do
                local yaw=$((i * 45 % 315))
                local filename="$base_filename-$i.png"
                screenshot-glb -i "$file" -w 512 -h 512 -m "orientation=0 0 $yaw" -o "$filename"
            done

            montage "$base_filename"-*.png -tile 6x1 -geometry +0+0 -background none -resize 3072x512 "montage-$base_filename.png"
            convert -dispose background -delay 50 -loop 0 "$base_filename"-*.png "$dir"/"$base_filename.gif"
            rm "$base_filename"-*.png
        fi

        if [[ $output_type == "png" || $output_type == "both" ]]; then
            screenshot-glb -i "$file" -w "$output_width" -h "$output_height" -m "orientation=0 0 180" -o "$dir"/"$base_filename.png"
        fi
    done
}

main() {
    local dir="$1"
    local filetype="$2"
    local output_type
    local output_width=512
    local output_height=512

    read -p "Do you want to make a png, gif, or both? " output_type
    if [[ $output_type == "png" ]]; then
        read -p "Enter width and height (default 512 512): " output_width output_height
    fi

    process_files "$dir" "$filetype" "$output_type" "$output_width" "$output_height"
}

main "$@"
