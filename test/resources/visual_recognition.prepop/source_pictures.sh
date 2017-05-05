#!/bin/bash

#  Read all *.txt files in this directory, and for each create a corresponding
#  *.zip file containing the downloaded pictures that were listed in the *.txt
#  file.  The *.txt files included with the distribution were identified as
#  Creative Commons licensed files acceptable for commercial reuse by Google
#  image search.

for i in *.txt; do
  class=$(basename "$i" .txt)
  echo "Processing ${class}..."
  cat ${class}.txt | while read url; do
    test -d images/$class || mkdir -p images/$class
    (cd images/$class || exit
    curl -O $url)
  done

  #  Create an array of file names becase zip does its own globbing.
  rm "${class}.zip"
  zip "${class}.zip" images/${class}/*.jpg images/${class}/*.JPG images/${class}/*.png
done
