#!/bin/bash
#
# setPassword.sh
#   script to ask user for a password and securely save it 

# get directory from user
read -p "Type the name of the folder you would like save the password in? " folderName
echo

# check if folder already exists and exit
if [ -d "$folderName" ]; then
    echo Folder already exists exiting..
    exit 1
fi
 
# Create the folder
mkdir "$folderName"

# set permissions on all created files to only allow user to read/write all other groups have no access
setfacl -d -m u::rwx $folderName   # set user to full rights
setfacl -d -m g::--x $folderName   # revoke all group rights
setfacl -d -m o::--- $folderName   # revoke all others permissions

# retrieve users password
read -p "Please enter the password to save: " userPassword
echo

# write the passsword hash to secret.txt
echo $userPassword | sha256sum > "$folderName/secret.txt"

echo "Password hash successfully written to $folderName/secret.txt"
echo
exit 0