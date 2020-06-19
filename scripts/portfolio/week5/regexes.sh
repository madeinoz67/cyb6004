#!/bin/bash
#
# regexes.sh
#  examples of grep using regex search

# find all sed statements

grep -r sed .
# find all lines starting with 'm'
grep -r "^m" .

# all lines containing 3 digits
grep -r -E "[0-9]{3}" .

# all echo statements with a min. of 3 words
# build using https://regex101.com/
grep -r -E "(echo\s+)(\S\w[A-Za-z]+\s){3,}" .

# all lines that would make a good password
# Top 15 Commonly Used Regex—Digital Fortress. (n.d.). Retrieved 15 June 2020, from https://digitalfortress.tech/tricks/top-15-commonly-used-regex/
grep -r -E "(?=(.*[0-9]))((?=.*[A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z]))^.{8,}" .