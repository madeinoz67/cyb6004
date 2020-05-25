#!/bin/bash
#
# foldermaker.sh
#   interactive script demonstrating user input to create weekly directories
#

# set base directory 
basedir=~/cyb6004/scripts/portfolio

read -p "Type the name of the folder you would like to create? " folderName

# check if folder exists
if [ -d "$basedir/$folderName" ]; then
    echo
    echo "Directory already exists"
    echo
    exit 1
fi

# Create folder
mkdir "$folderName"
mv "$folderName" "$basedir"
echo
echo "$basedir/$foldername creation successful"
echo

#display tree
tree $basedir
exit 0