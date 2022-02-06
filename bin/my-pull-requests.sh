#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -gt 2 ]; then
  echo "Illegal number of parameters"
  exit 1
fi

# Username
if [ "$#" -eq 0 ]; then
  echo -n Username:
  read -r -s username
  echo
elif [ "$#" -eq 1 ]; then
  username="$1"
fi

if [ -z "$BITBUCKET_URL" ]; then
  echo "Need to set BITBUCKET_URL"
  exit 1
fi

password=$(keyring get jira "$username")

if [ -z "$password" ]; then
  echo "Could not find \"jira $username\" in keyring"
  exit 1
fi

pr_response="$(curl -s "$BITBUCKET_URL/rest/api/1.0/dashboard/pull-requests?state=OPEN" \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'Accept-Language: en-US,en;q=0.5' \
  -H 'Content-Type: application/json; charset=utf-8' \
  -u "$username:$password")"

echo
echo "Pull requests:"
echo "$pr_response" | jq -rj '.values[] | "\(.title) - \(.links.self[0].href)\n"'
echo
