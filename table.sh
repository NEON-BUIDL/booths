#!/bin/bash

echo "| Preview | GLB |"
echo "| ------- | --- |"

for gif in *.gif; do
    base="${gif%.*}"
    echo "| ![$base]($gif){width=50%} | [$base.glb]($base.glb) |"
done

