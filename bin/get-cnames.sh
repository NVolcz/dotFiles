#!/usr/bin/env bash
set -euo pipefail

hostlist=$1

# shellcheck disable=SC2015
[ -f "$hostlist" ] && echo "Found $hostlist" || {
  echo "Must be provided a file"
  exit 1
}

while read -r line; do
  echo "#### $line #####"
  result=$(dig +nocmd "$line" any +multiline +noall +answer)
  echo "$result"
done <"$hostlist"
