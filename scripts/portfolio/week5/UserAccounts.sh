#!/bin/bash
#
# UserAccounts.sh
#
#   Displays /etc/passwd in a human readable table using AWK
#
clear
# cleanup by first removing comment lines using Sed then pipe to AWK for formatting and display
sed '/#/d' /etc/passwd | awk 'BEGIN {
        FS=":"
        print " ___________________________________________________________________________________________________"
        printf "| \033[34m%-25s\033[0m | \033[34m%-6s\033[0m | \033[34m%-6s\033[0m| \033[34m%-32s\033[0m | \033[34m%-16s\033[0m |\n", "Username", "UserID", "GroupID", "Home", "Shell"
        print "|___________________________|________|________|__________________________________|__________________|"
    }
    {
        # filer everything except those with '/bin/bash' in column $7
        if ($7 ~ /^\/bin\/bash$/)
            printf "| \033[33m%-25s\033[0m | \033[35m%-6s\033[0m | \033[35m%-6s\033[0m | \033[35m%-32s\033[0m | \033[35m%-16s\033[0m |\n",$1, $3, $4, $6, $7
    }
    END{
    print "|___________________________|________|________|__________________________________|__________________|"
    }'