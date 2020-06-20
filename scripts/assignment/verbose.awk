BEGIN {
    count=0
    FS=","
    printf "\n\033[95m______________________________________________________________\n"
    printf "\n\033[96m%-9s %-25s %s\n", "Status", "Detection Engine", "Result"
    printf "\033[95m_______________________________________________________________\n\n"
}
{
    count++
    printf "%-9s %-25s %s\n", $1, $2, $4
}
END {
    printf "\n\033[31mfilename: %s\n\n",filename
    printf "\033[1m"count"\033[24m detection engines see this file as malicious\033[m\n\n"
    printf " For more details visit:\n\n"
    printf "\thttps://www.virustotal.com/gui/search/%s\n\n",hash
}