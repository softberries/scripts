!#/bin/bash
#
#
# This script gets single still image from the MOV file in JPEG format
#
#
FILES=*.mov
for f in $FILES
do
	echo "Processing $f"
	ffmpeg -i "$f" -q:v 1 "${f%.mov}.jpeg"
done
