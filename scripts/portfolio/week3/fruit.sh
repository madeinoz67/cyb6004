#!/bin/bash
#
# fruit.sh
#   prints fruit names using for loop
#
clear

fruitArray=("Apple" "Mango" "Strawberry" "Orange" "Banana")

# iterate through the fruit array and print the names
for val in ${fruitArray[@]}; do
    echo "FRUIT: $val"
done