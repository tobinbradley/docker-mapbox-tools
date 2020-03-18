#! /bin/bash

echo "Input Font folder: " $1
echo "Output Glyph folder: " $2

for filename in $1/*.ttf; do
  # get nice folder name
  fontname=${filename/$1\//}
  fontname=${fontname/.ttf/}
  fontname=${fontname/-/}
  fontname=$(echo $fontname | sed -r -e "s/([^A-Z])([A-Z])/\1 \2/g")

  #make the stuff
  mkdir -p "$2/$fontname"
  build-glyphs $filename "$2/$fontname"
done