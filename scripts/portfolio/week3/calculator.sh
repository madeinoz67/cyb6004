#!/bin/bash
#
# calculator.sh
#   Arithmetic calculator in bash
#

BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
GREY=`tput setaf 7`
L_GREY=`tput setaf 8`
L_RED=`tput setaf 9`
L_GREEN=`tput setaf 10`
L_YELLOW=`tput setaf 11`
L_BLUE=`tput setaf 12`
L_MAGENTA=`tput setaf 13`
L_CYAN=`tput setaf 14`
WHITE=`tput setaf 15`
PURPLE=`tput setaf 129`
NORMAL=`tput sgr0`


# Get numbers from user and Display Menu of operations
echo -e "${GREY}-= Arithmetic Calculator =-${NORMAL}"
echo
echo "Enter two numbers: "
read num1
read num2

echo 
echo "Enter Operation :"
echo "1) ${BLUE}Add numbers${NORMAL}" 
echo "2) ${GREEN}Subtract numbers${NORMAL}" 
echo "3) ${RED}Multiply numbers${NORMAL}" 
echo "4) ${PURPLE}Divide numbers${NORMAL}" 
read op

# Select the operation
case $op in
        1)
            ans=$(echo "scale=2; $num1 + $num2;" | bc)
            ;;
        2)
            ans=$(echo "scale=2; $num1 - $num2;" | bc)
            ;;
        3)
            ans=$(echo "scale=2; $num1 * $num2;" | bc)
            ;;
        4)
            ans=$(echo "scale=2; $num1 / $num2;" | bc)
            ;;
        *) echo "invalid option $REPLY";;
esac

# display the answer
echo "${GREY}The Answer is:${WHITE} $ans ${NORMAL}"
echo


