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

# retrieve users password
read -sp "Please enter the password to save: " userPassword
echo

# write the password hash to secret.txt -n prevents hash calc of new line
echo -n $userPassword | sha256sum > "$folderName/secret.txt"

# set permissions on all created files to only allow user to read/write all other groups have no access
chmod -R 600 $folderName
chmod 600 $folderName/secret.txt

echo "Password hash successfully written to $folderName/secret.txt"
echo
exit 0