# vtfc - Virus Total file Checker

**CYB6004 - Stephen Eaton**

## Purpose
This is a command line script that checks a file on [Virus Total](https://www.virustotal.com/gui/home/search) to see if it malicious or not by using their free API

**Usage:**
  ````
  vtfc.sh -h                                Display this help message
  vtfc.sh [-d] -a APIKEY                    Sets Virus Total API Key ([-d] debug)
  vtfc.sh [-d] [-v] -s FILENAME             Check file on virus total using sha1 hash ([-d] debug, [-v] verbose results)
  vtfc.sh [-d] [-v] -m FILENAME             Check file on virus total using md5 hash ([-d] debug, [-v] verbose results)
  ````

## Exit codes ##

0 - Normal exit, no malicious file found  
1 - Possible Malicious file found  
2 - requirements not installed  

## Requirements ##

1. An api key is required for this script to operate correctly. To get your API KEY please see https://developers.virustotal.com/v3.0/reference#getting-started
2. curl needs to be installed on the system
3. jq needs to be installed on the system - https://stedolan.github.io/jq/
4. verbose template file verbose.awk is required by the script

## Instructions ##

### Setting the API Key ###

If you do not already have a Virus Total Account, please register via https://www.virustotal.com/gui/sign-in

Once registered the API key is accessed under your account settings, copy this key

The api need to be set `vtfc.sh -a <apikey>` where `<apikey>` is the key you copied from you VirusTotal Account.  This is will create/update the configuration item `VT_APIKEY` in the config file located in ~/.vtrc

### Perfoming a file check ###

The search is performed on a given filename by calculating either an md5 hash `-m` or a sha1 has `-s`  this has is used via the API interface to search VirusTotal, if results are found then a notice is displayed that the file may be malicious.  e.g. `vtfc -s <filename>`

Detailed results can be selected using the `-v` flag.  e.g. `vtfc -v -m <filename>`

## Testing and Debugging ##
### Testing ###

This script uses the bats test framework https://github.com/bats-core/bats-core/blob/v1.2.0/README.md to perform automated unit testing.

#### Requirements ####

bats needs to be installed to perform the tests see https://github.com/bats-core/bats-core/blob/v1.2.0/README.md#installation

#### Running the tests ####

by running the 'runtests.sh' will execute all tests in the *tests* folder

````
  ./runtests.sh
  
 ✓ tests dependency - curl is installed
 ✓ tests dependency - jq is installed
 ✓ invoke script with no parameters
 ✓ invoke script with no filename
 ✓ invoke script with filename only
 ✓ invoke add apikey with no key
 ✓ md5 search of eicar.com testfile
 ✓ md5 search of eicar.com testfile - verbose result
 ✓ md5 search of non-malicious file
 ✓ sha1 search of eicar.com testfile
 ✓ sha1 search of eicar.com testfile - verbose result
 ✓ sha1 search of non-malicious file

12 tests, 0 failures
````

### Debugging ###

By enable the debug flag `-d` when running the script will print out additional information helpful in troubleshooting a problem

It is important to note that when debug is enabled the tmp directory created will not get deleted, this will need to be removed manually

## Notes ##

1. The free API is limited to 4 requests per minute
2. The free API is limited to a maximum of 1,000 requests per day
3. Antivirus may pick up the eicar.com test files used in unit testing, these are false positives and can be excluded.  See https://www.eicar.org/?page_id=3950

## Project Directory ##

````
.
├── README.md
├── runtests.sh
├── tests
│   ├── testfiles
│   │   ├── eicar.com
│   │   ├── eicar.com.txt
│   │   └── normal.txt
│   └── vtfc.bats
├── verbose.awk
└── vtfc.sh
````