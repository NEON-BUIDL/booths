#!/bin/bash

echo "| Preview | GLB |"
echo "| ------- | --- |"

for gif in *.gif; do
    base="${gif%.*}"
    echo "| ![$base]($gif) | [$base.glb]($base.glb) |"
done

