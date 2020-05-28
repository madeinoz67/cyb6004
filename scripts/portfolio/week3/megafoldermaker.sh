#!/bin/bash
#
# megafoldermaker.sh
#   Generates all the portfolio folders
#

if (( $#!=2 )); 
then
    echo "Error, must provide two numbers " && exit 1
fi

# for every number between the first argument and the last
for((i=$1;i<=$2;i++)); do
    # create new folder
    echo "Creating directory number $1"
    mkdir "week$i"
done

