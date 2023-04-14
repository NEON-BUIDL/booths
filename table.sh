#!/bin/bash


preview="$1"
glb_file="$2"

echo "| Preview | GLB |"
echo "| ------- | --- |"

for gif in *.gif; do
    base="${gif%.*}"
    echo "| ![$base]($gif) | [$base.glb]($base.glb) |"
done

