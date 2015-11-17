!#/bin/bash
FILES=*.mov
for f in $FILES
do
	echo "Processing $f"
	ffmpeg -i "$f" -vf scale=800:-1 -r 10 -f image2pipe -vcodec ppm - |\
				convert -delay 5 -layers Optimize -loop 0 - "${f%.mov}.gif"
done
