#!/bin/bash
#
# menu.sh
#  provides a menu around week2 scripts
#

#preven <CTRL> C from exiting program
trap '' 2 

#define constants 
readonly passwordIsOK=0

# clear screen
clear

#perform password check
./passwordCheck.sh

# get the last exit code and check password result
passwordCheckResult=$?
if (( passwordCheckResult != passwordIsOK )); then
    echo Goodbye!
    exit 1
fi

# will continioulsy loop to redisplay menu until exit is selected
while true; do
    # Display Menu Structure and get user input
    echo 
    echo "-= Menu =-"
    echo
    options=(
        "Create a Folder" 
        "Copy a Folder" 
        "Set a Password" 
        "Display Tree"
        "Exit"
    )

    PS3="Enter a number (1-${#options[@]}): "

    select opt in "${options[@]}"; do
        case $REPLY in
            1)
                echo
                ./foldermaker.sh;
                break
                ;;
            2)
                echo
                ./foldercopier.sh;
                break
                ;;
            3)
                echo
                ./setPassword.sh;
                break
                ;;
            4)
                tree; 
                break
                ;;
            5)
                break 2
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
done