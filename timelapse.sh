#
# create timelapse video from images
#

shrink_image() {
  local filename=$1
  convert ./$filename \
    -resize '3840x2160^' \
    -gravity center \
    -crop '3840x2160+0+0' \
    ../4k/$filename

 convert "../4k/$filename" \
  -gravity SouthEast \
  -pointsize 22 \
  -fill white \
  -annotate +30+30  %[exif:DateTimeOriginal] \
  "../4k/date_$filename";
}

echo "resizing files..."
mkdir -p ./4k
cd ./raw
ls *.JPG | parallel --eta shrink_image {1}