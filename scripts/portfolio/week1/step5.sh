#!/bin/sh
#
# Script to add a new weekly directory to portfolio
# this counts the number of existing directories and then creates the next week number
#

# set base directory 
basedir=~/Documents/1_Masters-study/cyb6004/scripts/portfolio

# count of directories
weekssofar=$(find $basedir -type d -mindepth 1 | wc -l)

#next number of week 
weektoadd=$((weekssofar + 1))

# add the new directory
mkdir $basedir/week${weektoadd}
