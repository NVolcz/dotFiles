#!/bin/env bash
#set -e

hostlist=$1

[ -f "$hostlist" ] && echo "Found $hostlist" || { echo "Must be provided a file"; exit 1; }

while read line
do
	echo "#### $line #####"
	result=$(dig +nocmd "$line" any +multiline +noall +answer)
#   	result=$(host -t cname "$line")
   	echo $result
done < "$hostlist"
