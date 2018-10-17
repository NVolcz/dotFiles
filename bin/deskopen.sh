#!/bin/sh
# script to start applications in .desk files
# borrowed from: https://askubuntu.com/a/5174
grep '^Exec' "$1" | tail -1 | sed 's/^Exec=//' | sed 's/%.//'
