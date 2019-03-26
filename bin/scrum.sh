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
  updatedDate="-1d"
elif [ "$#" -eq 1 ]; then
  username="$1"
  updatedDate="-1d"
elif [ "$#" -eq 2 ]; then
  username="$1"
  updatedDate="$2"
fi

if [ -z "$JIRA_URL" ]; then
    echo "Need to set JIRA_URL"
    exit 1
fi  

password=$(keyring get jira "$username")

if [ -z "$password" ]; then
  echo "Could not find \"jira $username\" in keyring"
  exit 1
fi

search_response=$(curl -s -u "$username:$password" "$JIRA_URL/jira/rest/api/2/search" -H "Content-type: application/json" -X POST -d "{\"jql\": \"(issueFunction in commented (\\\"by $username\\\") OR issue in watchedIssues()) AND updatedDate > $updatedDate\" }")

if ! jq -e . >/dev/null 2>&1 <<<"$search_response"; then
    echo "Failed to parse JSON, or got false/null"
    echo "$search_response"
    exit 1
fi

echo "$search_response" | jq -r '.issues[] | .key + " ~ " + .fields.summary + " ~ " + .fields.status.name'
