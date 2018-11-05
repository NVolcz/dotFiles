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

if [ -z "${JIRA_SESSION_ID:-}" ]; then
  # Always ask for password
  echo -n Password:
  read -r -s password
  echo

  # TODO: check if JIRA_SESSION_ID is set/valid
  if ! jira_auth "$username" "$password"; then
  	exit 1
  fi
fi

search_response=$(curl -s $JIRA_URL/jira/rest/api/2/search -b JSESSIONID=${JIRA_SESSION_ID} -H "Content-type: application/json" -X POST -d "{\"jql\": \"issueFunction in commented (\\\"by $username\\\") AND updatedDate > $updatedDate\" }")

if ! jq -e . >/dev/null 2>&1 <<<"$search_response"; then
    echo "Failed to parse JSON, or got false/null"
    exit 1
fi

echo "$search_response" | jq -r '.issues[] | .key + " ~ " + .fields.summary + " ~ " + .fields.status.name'
