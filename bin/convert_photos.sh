#!/bin/bash

cd app/assets/images/photo_grid;

for file in ./originals/*; do 
  convert -auto-orient -resize 500x800 $file "./resized/$(basename $file)"; 
done

for file in ./resized/*; do 
  cwebp -q 80 "$file" -o "./dist/$(basename $file .jpg).webp";
done
