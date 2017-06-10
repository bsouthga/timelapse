#!/usr/bin/env bash

#
# reshape photos to 4k frames and add timestamp
#
shrink_image() {
  local filename=$1

  convert ./raw/$filename \
    -resize '3840x2160^' \
    -gravity NorthEast \
    -crop '3840x2160+0+0' \
    -pointsize 72 \
    -fill white \
    -undercolor '#00000080' \
    -annotate +30+30  %[exif:DateTimeOriginal] \
    ./4k/$filename
}
export -f shrink_image

echo "resizing files..."
mkdir -p ./4k
ls -A1 ./raw | parallel --eta shrink_image {1}