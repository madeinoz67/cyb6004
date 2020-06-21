#!/bin/bash
#
# vtfc.sh  - Virus Total File Checker
#
# Author: 
#   Stephen Eaton
#
# Purpose:
#  This CLI script will check a file via the Virus Total Free API to see if it is listed as malicious or not
#  
#   Exit Codes:
#       0 - file is not malicious
#       1 - file possibly malicious
#       2 - Requirements not installed 
#
#  Please note the free api is limited to 4 requests per minute
#
# References:
#
#   bash—Checking wget’s return value [if]. (n.d.). Stack Overflow. Retrieved 20 June 2020, from https://stackoverflow.com/questions/2717303/checking-wgets-return-value-if
#   bash—How do I use shell variables in an awk script? (n.d.). Stack Overflow. Retrieved 20 June 2020, from https://stackoverflow.com/questions/19075671/how-do-i-use-shell-variables-in-an-awk-script
#   bash:tip_colors_and_formatting—FLOZz’ MISC. (n.d.). Retrieved 20 June 2020, from https://misc.flogisoft.com/bash/tip_colors_and_formatting
#   Downloads. (n.d.). Retrieved 20 June 2020, from https://ec.haxx.se/usingcurl/usingcurl-downloads
#   Nihamkin, A. (23:00:00+03:00). Experimenting with Bats. Artium Nihamkin’s Blog. http://www.nihamkin.com/experimenting-with-bats.html
#   Format Modifiers (The GNU Awk User’s Guide). (n.d.). Retrieved 20 June 2020, from https://www.gnu.org/software/gawk/manual/html_node/Format-Modifiers.html
#   Getopts—From the Shell Scripting Tutorial Tips. (n.d.). Retrieved 19 June 2020, from https://www.shellscript.sh/tips/getopts/
#   How ‘Exit Traps’ Can Make Your Bash Scripts Way More Robust And Reliable. (n.d.). Retrieved 19 June 2020, from http://redsymbol.net/articles/bash-exit-traps/
#   Jq Manual (development version). (n.d.). Retrieved 20 June 2020, from https://stedolan.github.io/jq/manual
#   linux—Check for existence of wget/curl. (n.d.). Stack Overflow. Retrieved 19 June 2020, from https://stackoverflow.com/questions/14411103/check-for-existence-of-wget-curl
#   Overview. (n.d.). VirusTotal. Retrieved 20 June 2020, from https://developers.virustotal.com/v3.0/reference
#   
# enough of the formalities....lets get this party started....

# checks for required helper applications and files
checkRequirements(){
    if [ ! -x "$(which curl)" ]; then 
        echo 2>&1 "Requirements not met, please install 'curl'"
        exit 2
    fi
    if [ ! -x "$(which jq)" ]; then
        echo 2>&1 "Requirements not met, please install 'jq' - https://stedolan.github.io/jq/ " 
        exit 2
    fi
}

# Returns the MD5 Hash of the file 
getFileMd5() {
    fileHash=`md5sum $1 | cut -f1 -d ' '`
    [[ $DEBUG ]] && echo -e "DEBUG MD5: $fileHash\n"
}

# Returns the SHA1 Hash of the file 
getFileSha1() {
    fileHash=`sha1sum $1 | cut -f1 -d ' '`
    [[ $DEBUG ]] && echo -e "DEBUG SHA1: $fileHash\n"
}

# Sets Virus Total API KEY
#   as the key is the only config item being stored it just overwrites the file
setApiKey() {
    echo "VT_APIKEY=$1" > $configFile
    [[ $DEBUG ]] && echo -e "DEBUG: VT_APIKEY=$1 saved in $configFile\n"
}

# script usage help
usage() {
    echo -e "\nUsage:"
    echo -e "\t$0 -h \t\t\t\t\t Display this help message"
    echo -e "\t$0 [-d] -a APIKEY \t\t\t Sets Virus Total API Key ([-d] show debug)"
    echo -e "\t$0 [-d] [-v] -s FILENAME \t\t Check file on virus total using SHA1 hash ([-v] verbose results [-d] show debug)"
    echo -e "\t$0 [-d] [-v] -m FILENAME \t\t Check file on virus total using MD5 hash ([-v] verbose results [-d] show debug)\n"
}

# Performs the search on Virus Total
doSearch() {
    local url=$1

    [[ $DEBUG ]] && echo -e "performSearch():"
    [[ $DEBUG ]] && echo -e "\t URL: $url"
    [[ $DEBUG ]] && echo -e "\t VT_APIKEY: $VT_APIKEY\n"

    # perform the search by using curl
    # Search needs to set headers with APIKEY of request first and then perform quietly
    # output is saved to scratch directory output.txt and will get deleted when cleaned-up
    if [ -x "$(which curl)" ]; then
        curl --request GET \
             --silent \
             --url $url \
             --header "X-Apikey: $VT_APIKEY" \
             --output $scratch/output.txt
        if [ $? -ne 0 ]; then
            echo "$RED ERROR: Failed to perform API search using curl! $RESET"
            exit 1
        fi
    else
        echo -e "$RED ERROR: Could not find curl, please install. $RESET" >&2
    fi
}

# clean-up housekeeping when exiting
cleanup() {
    if [[ $DEBUG ]]; then
        echo -e "DEBUG: $RED Scratch directory not removed! - Please remove manually using 'rm -rf $scratch' $RESET"
    else
        rm -Rf $scratch                     # removes the scratch directory
    fi
}

##############################################################################
## Main Starts here

# Define foreground colours
export RED="\033[31m"
export GREEN="\033[32m"
export YELLOW="\033[33m"
export BLUE="\033[34m"
export PURPLE="\033[35m"
export CYAN="\033[36m"
export LCYAN="\033[96m"
export LMAGENTA="\033[95m"
export RESET="\033[m"

trap cleanup EXIT                       # trap the EXIT signal to run cleanup() on every exit

configFile="$HOME/.vtfc"                # location of config file containing API key
outputFile="output.txt"                 # output filename
APIURL="https://www.virustotal.com/api/v3/files" # base API url for searching files

unset VERBOSE ACTION DEBUG URL RESULTS fileHash     # clear variables

checkRequirements                       # check required helper utilities are installed

# process parameter options passed
while getopts "advms?h" opt; do
    case ${opt} in
        a ) ACTION=setApiKey ;;         # sets VirusTotal API Key in config file
        d ) DEBUG=true ;;               # enables debug
        m ) ACTION=getFileMd5 ;;        # check file using md5sum
        s ) ACTION=getFileSha1 ;;       # check file using sha1sum
        v ) VERBOSE=true ;;             # Verbose - display detailed results otherwise a simple message is displayed
        h|? ) usage ;;                  # display help message
   esac
done
# $OPTIND is now set to 2 or 3 depending on the switches passed, 
#   so needs shifting back 1 to get the FILENAME or APIKEY ($@)
shift $((OPTIND-1))

# validate user input
[ -z "$ACTION" ] && { usage; exit 2; }  # no parameters passed so display the usage
[ -z "$@" ] && { usage; exit 2; }       # no filename or APIKEY passed so display the usage

# check if the config file containing the API key exists in user home directory
if [ -f "$configFile" ]; then
    . $configFile                       # load config

    # check VT_APIKEY exists only if its not being set
    if [[ $ACTION != setApiKey && -z "$VT_APIKEY" ]]; then
        echo -e "\n $RED Please set the API KEY using the '-a' option $RESET\n"
        usage 
        exit 2
    fi
else
    echo -e "\n Config File '$configFile' not found! \n Please set API KEY using the '-a' option \n"
    usage
    exit 2
fi

[[ $DEBUG ]] && echo -e "DEBUG: $YELLOW VT_APIKEY: $VT_APIKEY $RESET\n"

scratch=$(mktemp -d -t vtfc)            # creates tmp working directory 'vtfc.<procid>' in system tmp folder
[[ $DEBUG ]] && echo -e "DEBUG: scratch directory: $scratch\n"

# Performs the action selected
$ACTION $@

# make things more readable moving forward
URL="$APIURL/$fileHash"
RESULTS="$scratch/$outputFile"

# Do API Search
if [[ $ACTION == getFileSha1 || $ACTION == getFileMd5 ]]; then
    doSearch "$URL"
    if [[ $? -ne 0 ]]; then 
        echo -e "$RED ERROR: API search failed $RESET"        # error connecting API
        exit $?                                               # exit with curls error code
    else
        # grep results for "NotFoundError" == no results found by search engine
        grep "NotFoundError" -q $RESULTS
        if [[ $? = 0 ]]; then
            echo -e "\n$GREEN This file is unlikely to be malicious: $@ $RESET\n"       # do a happy dance, no results found!
        else
            if [[ $VERBOSE ]]; then 
                # process and display verbose output using jd, clean up with sed and then format output using awk, pass filename and hash into awk formatting template
                cat $RESULTS | \
                    jq -r '.data.attributes.last_analysis_results[] | select(.category=="malicious") | [.category, .engine_name, .engine_version, .result] | @csv' | \
                    sed 's/"//g'| \
                    awk -v filename="$@" -v hash="$fileHash" -f verbose.awk
                exit 1
            else
                # Default (non-verbose) output
                cat $RESULTS | \
                    jq -r '.data.attributes.last_analysis_results[] | select(.category=="malicious") | [.category, .engine_name, .engine_version, .result] | @csv' | \
                    sed 's/"//g'| \
                    awk 'END{printf "\n\033[31mThis file is likely malicious\n\n rerun with -v (verbose) option to see more details\n\n\033[m"}'
                exit 1
            fi
        fi
    fi
fi