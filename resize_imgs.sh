#!/bin/bash
#
# This script resizes all JPEG images in the current directory
# and saves them with .jpg extension
#
FILES=*.jpeg
for f in $FILES
do
	echo "Processing $f"
	convert "$f" -resize 600x "${f%.jpeg}.jpg"
done
