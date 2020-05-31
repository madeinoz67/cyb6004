#!/bin/bash
#
# InternetDownloader.sh
#   prompts for a url and will download the file to a given location
#
clear
while true
do
    echo -n "Please enter the URL of the file to download (Type 'exit' to Quit): "
    read urltoget

    if [ "$urltoget" = "exit" ]; then
        # user typed exit
        exit 0
    fi

    echo -n "Type the location of where you would like to download the file to: "
    read downloadlocation

    # check if download location exists
    if [ -d "$downloadlocation" ]; then
        #get the url using wget
        wget $urltoget
    else
        echo
        echo "$downloadlocation does not exist"
    fi
    
done

