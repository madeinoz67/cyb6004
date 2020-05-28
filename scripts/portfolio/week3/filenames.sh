#!/bin/bash
#
# filenames.sh
#   reads in file and directory names from a file and check if a file or directory
clear

for line in $(cat $1);
do
    # check if $line represents a directory
    if [ -d "$line" ]; then
        msg="That's a directory"

    # check if $line represents a file
    else if [ -f "$line" ]; then
            msg="That file exists"
    
    #$line in file is unknown
        else
            msg="I don't know what that is"
        fi
    fi
    # display the message
    echo "$line - $msg"
    
done