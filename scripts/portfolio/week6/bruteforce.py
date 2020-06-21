#!/usr/bin/python3
#
# bruteforce.py
#   will bruteforce a password using all combinations of characters (...and takes forever)
#   
# References:
#
#  Python Brute Force algorithm. (n.d.). Stack Overflow. Retrieved 21 June 2020, from https://stackoverflow.com/questions/11747254/python-brute-force-algorithm

import hashlib
import string
from itertools import chain, product

# bruteforce generates a word list of all the combinations of charsets up to a max length
#   creates a list of all combinations i.e. ['a','b'...'aa','ab'...'abcdef'...'zzzzzzzzy','zzzzzzzzz']
def bruteforce(charset, maxlength):
    return (''.join(candidate)
        for candidate in chain.from_iterable(product(charset, repeat=i)
        for i in range(1, maxlength + 1)))

#hidden password hash
passwordHash = "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"

# iterate through the wordlist generated by bruteforce() and try each item, using only alpha [a-z] lowercase to have a narrow searchspace
for attempt in bruteforce(string.ascii_lowercase, 9):
        #hash the word
        attemptHash = hashlib.sha256(attempt.encode("utf-8")).hexdigest()
        print(f"Trying password {attempt}:{attemptHash}")
        #if the hash is the same as the correct password's hash then we have cracked the password!
        if(attemptHash == passwordHash):
            print(f"Password has been cracked! It was {attempt}")
            break