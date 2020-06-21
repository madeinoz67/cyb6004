#!/bin/bash
#
# Awkformat.sh
#
#   formats a text file in a table using AWK
#
clear
echo "Google Server IPs:"
awk 'BEGIN { 
        FS=":"   # field seperator
        print "_________________________________"
        print "|  \033[34mServer Type\033[0m |  \033[34mIP\033[0m            |";
    }
    {
        printf "|  \033[33m%-11s\033[0m |  \033[35m%-14s\033[0m|\n", $1, $2
    }
    END {
        print("|______________|________________|")
    }' input.txt