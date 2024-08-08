#!/usr/bin/env python3

# This tool takes worldmap exported by mapExport.py, adds an overlay with town names, and saves it into the docs directory.

from PIL import Image


# Open the raw exported worldmap.
worldmap = Image.open(r"map00.png")

# Copy it to the docs/image directory.
worldmap.save("../docs/images/worldmap_base.png")

# Change the mode so the overlay can use a color not already in the base image.
worldmap = worldmap.convert(mode='RGB')

# Open the town map overlay image.
overlay = Image.open(r"../docs/images/worldmap_overlay.png")

# Combine the two images.
worldmap.paste(overlay, (0,0), mask=overlay)

# Save the labeled image into docs.
worldmap.save("../docs/worldmap.png")
