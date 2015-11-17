!#/bin/bash
#
#
# This script converts all MOV files found in the current directory into animated GIF images
# with the same name
# To create a MOV file on OSX (screen cast video file) :
# 1. Open up Quicktime
# 2. Select Cmd + Ctrl + N
# 3. Press record
# 4. Select the window area
# 5. When finished select Cmd + Ctrl + Esc to finish recording
#
#
FILES=*.mov
for f in $FILES
do
	echo "Processing $f"
	ffmpeg -i "$f" -vf scale=800:-1 -r 10 -f image2pipe -vcodec ppm - |\
				convert -delay 5 -layers Optimize -loop 0 - "${f%.mov}.gif"
done
