#!/usr/bin/env bash 
 
# Modified version of: https://gist.github.com/peterc/63893
 
NOT_MATCHED='^No match|^NOT FOUND|^Not fo|AVAILABLE|^No Data Fou|has not been regi|No entri'

if ! [ -x "$(command -v whois)" ]; then
	echo >&2 "I require whois but it's not installed.  Aborting."
	exit 1
fi

if [ "$#" == "0" ]; then 
    echo "You need tu supply at least one argument!" 
    exit 1
fi 

while read -r line; do
    if whois "$line" | grep -E -q "$NOT_MATCHED"; then 
        echo "$line : available" 
    fi

done < "$1"