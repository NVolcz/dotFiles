#!/bin/bash
#
# ImgurAlbum.sh
#
# Bash script to download images for an Imgur album
#
if [ -z "$1" ]; then
   echo "ImgurAlbum: missing Album ID"
   echo "Usage: ImgurAlbum [Album ID]"
   exit
else
   echo "Creating directory: $1"
   mkdir $1
   cd $1
   echo "Fetching Album Images..."
   wget https://api.imgur.com/3/album/$1/images.xml --header='Authorization: Client-ID 1b138bce405b2e0' --quiet --output-document images-temp.xml
   imageCount=$(xmllint --xpath "count(/data/item)" images-temp.xml)
   echo "Downloading Images to: ${PWD}"
   for (( i=1; i<=$imageCount; i++ )); do
      imageLink=$(xmllint --xpath "/data/item[$i]/link/text()" images-temp.xml)
      echo "Downloading Image $i of $imageCount: $imageLink"
      wget -N $imageLink --quiet 
   done
   echo "Removing temporary files..."
   rm images-temp.xml
   echo
   echo "DONE: Images saved to: ${PWD}"
   echo
   cd ..
   exit
fi
