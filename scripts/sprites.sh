#!/bin/bash

for file in *.glb; do
    for i in {0..5}; do
        yaw=$(expr $i \* 45 % 315) # Calculate yaw angle, wrapping around to 0 after 7 increments of 45 degrees
        filename=$(basename "$file" .glb)"-$i.png" # Construct filename
        screenshot-glb -i "$file" -w 512 -h 512 -m "orientation=0 0 $yaw" -o "$filename" # Take screenshot
    done
    # Combine screenshots into a grid with transparent background
    montage $(basename "$file" .glb)-*.png -tile 6x1 -geometry +0+0 -background none -resize 3072x512 montage-$(basename "$file" .glb).png
    # Combine all images into a final GIF
    convert -dispose background -delay 50 -loop 0 $(basename "$file" .glb)-*.png $(basename "$file" .glb).gif
    rm "$(basename "$file" .glb)"-*.png
done
