#!/bin/bash
#
# foldercopier.sh
#   script to copy folders

read -p "type the name of the folder you would like to copy: " srcFolder
echo
 
# Check if the name is a valid directory
if [ -d "$srcFolder" ]; then
    # copy it to a new location
    read -p "Type the name of the destination folder: " dstFolder
    echo

    # check destination folder doesnt exist
    if [ -d "$dstFolder" ]; then
        echo "Destination directory exists...exiting..."
        echo 
        exit 2
    fi
    
    cp -r "$srcFolder" "$dstFolder"

    echo "successfully copied $srcFolder to $dstFolder"
    echo

 else
    # print an error
    echo "I couldn't find the source folder...exiting..."
    exit 1
 fi

tree ../
exit 0