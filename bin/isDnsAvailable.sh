#!/bin/bash 
 
# Modified version of: https://gist.github.com/peterc/63893
 
if [ "$#" == "0" ]; then 
    echo "You need tu supply at least one argument!" 
    exit 1
fi 

while read line; do
  whois "$line" | grep -E -q '^No match|^NOT FOUND|^Not fo|AVAILABLE|^No Data Fou|has not been regi|No entri' 
  if [ $? -eq 0 ]; then 
      echo "$line : available" 
  fi
done < "$1"