#!/bin/bash
#
# GuessingGame.sh
#   Guessing game using functions

 #This function prints a given error
printError()
{
    echo -e "\033[31mERROR:\033[0m $1"
}

#This function will get a value between the 2nd and 3rd arguments
getNumber()
{
    read -p "$1: "
    while (( $REPLY < $2 || $REPLY > $3 )); do
        printError "Input must be between $2 and $3"
        read -p "$1: "
    done
    # update global variable with user response
    guess=$REPLY
}

clear

# initialise global variable
guess=0
numToGuess=42

while true;
do
    getNumber "please type a number between 1 and 100" 1 100
    if (( $guess == $numToGuess )); then
        # Corrcct Answer so print congrats msg and exit
        echo "Correct - Well Done"
        break
    elif (( $guess < $numToGuess )); then
        echo " Guess too low, try again"
    elif (( $guess > $numToGuess )); then
        echo "Guess too high, try again"
   fi 
done