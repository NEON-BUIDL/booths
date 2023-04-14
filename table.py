import os
import sys
import math
from pathlib import Path

def main():
    if len(sys.argv) < 2:
        print("Usage: python table.py directory/")
        sys.exit(1)

    directory = sys.argv[1]
    pairs = {}

    for glb in Path(directory).glob("*.glb"):
        base = glb.stem
        png = glb.with_suffix(".png")
        if png.exists():
            pairs[base] = (glb, png)

    count = len(pairs)
    size = int(math.sqrt(count))

    ## Change this later to be based on repo name
    print("# Booths", end="")
    print("[![Asset Pallet Generator](https://github.com/NEON-BUIDL/booths/actions/workflows/main.yml/badge.svg)](https://github.com/NEON-BUIDL/booths/actions/workflows/main.yml)")
    print("Remixable 3D booth assets for showcasing your projects with")
    print("\n")
    print("Download templates: https://sketchfab.com/3d-models/remixable-booth-templates-d565cb7935744d6190b7d23b260e743b")
    print("\n")

    print("|", end="")
    for i in range(size):
        print(f" {i + 1} |", end="")
    print()

    print("|", end="")
    for i in range(size):
        print(" --- |", end="")
    print()

    index = 0
    for key, value in pairs.items():
        if index % size == 0:
            print("|", end="")

        glb, png = value
        print(f" [![{key}]({png})]({glb}) |", end="")

        index += 1

        if index % size == 0:
            print()

    print()

if __name__ == "__main__":
    main()
