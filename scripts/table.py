import os
import sys
import math
from pathlib import Path

def main():
    if "--head" in sys.argv:
        print("# Booths\n")
        print("[![Asset Pallet Generator](https://github.com/neon-buidl/booths/actions/workflows/main.yml/badge.svg)](https://github.com/neon-buidl/booths/actions/workflows/main.yml)\n")
        print("Download templates: https://sketchfab.com/3d-models/remixable-booth-templates-d565cb7935744d6190b7d23b260e743b\n")
        print("\n")
        sys.exit(0)

    if len(sys.argv) < 2:
        print("Usage: python table.py directory/")
        sys.exit(1)

    directory = sys.argv[1]
    pairs = {}

    for root, dirs, files in os.walk(directory):
        for glb in files:
            if glb.endswith(".glb"):
                base = Path(glb).stem
                png = Path(root) / (base + ".png")
                if png.exists():
                    pairs[base] = (Path(root) / glb, png)

    count = len(pairs)
    size = int(math.sqrt(count))

    ## Change this later to be based on repo name
    print(f" ## {directory}")
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

