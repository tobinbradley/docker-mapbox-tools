#! /bin/bash

echo "Input SVG folder: " $1
echo "Output Sprite folder: " $2

node /scripts/sprite.js $1 $2