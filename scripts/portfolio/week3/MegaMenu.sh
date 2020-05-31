#!/bin/bash
#
# MegaMenu.sh
#  provides a menu around all scripts so far
#

#set path in which to look for scripts
export PATH=$PATH:../week1:../week2:../week3

#prevent <CTRL> C from exiting program
trap '' 2 

#define constants 
readonly passwordIsOK=0
readonly basedir=../
# clear screen
clear

#perform password check
passwordCheck.sh

# get the last exit code and check password result
passwordCheckResult=$?
if (( passwordCheckResult != passwordIsOK )); then
    echo Goodbye!
    exit 1
fi

# will continuously loop to redisplay menu until exit is selected
while true; do
    # Display Menu Structure and get user input
    echo 
    echo "-= Menu =-"
    echo
    options=(
        "Create a Folder" 
        "Copy a Folder" 
        "Set a Password" 
        "Calculator"
        "Create Week Folders"
        "Check Filenames"
        "Download a File"
        "Exit"
    )

    PS3="Enter a number (1-${#options[@]}): "

    select opt in "${options[@]}"; do
        case $REPLY in
            1)
                echo
                foldermaker.sh;
                break
                ;;
            2)
                echo
                foldercopier.sh;
                break
                ;;
            3)
                echo
                setPassword.sh;
                break
                ;;
            4)
                calculator.sh; 
                break
                ;;
            5)
                megafoldermaker.sh 4 6
                break
                ;;
            6)
                filenames.sh filenames.txt 
                break
                ;;
            7)
                InternetDownloader.sh 
                break
                ;;
            8)
                break 2
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
done