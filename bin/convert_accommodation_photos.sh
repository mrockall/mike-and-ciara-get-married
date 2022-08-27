#!/bin/bash

cd app/assets/images/accommodations;

for file in ./originals/*; do 
  convert -auto-orient -resize 250x150 $file "./resized/$(basename $file)"; 
done

for file in ./resized/*; do 
  cwebp -q 80 "$file" -o "./dist/$(basename $file .jpeg).webp";
done
