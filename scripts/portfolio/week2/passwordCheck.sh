#!/bin/bash
#
# passwordCheck.sh
#   script to ask user for a password and check it against a password stored in secret.txt
#   password correct exit 0
#   password incorrect exit 1
#   secrets file or folder doesnt exist exit 2

# get directory from user
read -p "Please enter the folder the password is stored in: " secretFolder
echo

# check if secrets folder exists and exit if it doesnt
if [ ! -d "$secretFolder" ]; then
    echo "Sorry I can't find the secrets folder...exiting..."
    exit 2
fi

# check if file secret.txt exist
if [ ! -f "$secretFolder/secret.txt" ]; then
    echo "folder $secretFolder does not contain 'secret.txt'...exiting"
    exit 2
fi

# get users password and hide user input
read -sp "Please enter your password: " userPassword
echo

# calculate hash of user input
userPasswordHash=$(echo -n $userPassword | sha256sum)

# retrieve hash stored in secret.txt
secretHash=$(cat $secretFolder/secret.txt)

# check if hashes match
if [ "$userPasswordHash" = "$secretHash" ]; then
    echo Access Granted
    exit 0
else
    echo Access Denied
    exit 1
fi