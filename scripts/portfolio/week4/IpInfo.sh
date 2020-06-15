#!/bin/bash
 #get info about networking from the ifconfig command
 net_info="$(ifconfig)"

 # parse output ifconfig address lines using sed  
 # /n (newline) and /t (tabs) are escaped to work correctly
 #
 addresses=$(echo "$net_info" | sed -n '/inet / {
    s/inet/IP Address:/
    s/netmask/\\n\\t\\tSubnet Mask:/
    s/broadcast/\\n\\t\\tBroadcast Address:/
    p
 }')
 #format output
 echo -e "IP addresses on this computer are:\n$addresses"