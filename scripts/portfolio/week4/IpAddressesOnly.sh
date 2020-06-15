#!/bin/bash
#
# IpAddressesOnly.sh
#  Displays network Addresses configures of the computer its executed on
#

# use sed to parse and modify the output of IpInfo.sh 
# sed looks for each line starting with 'IP Address' and prints with the p if found
IP_Addresses=$(./IpInfo.sh | sed -n '/IP Address:/ p')

echo -e "IP Addresses on this Computer are: \n$IP_Addresses"

exit 0