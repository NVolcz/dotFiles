#!/usr/bin/env bash
set -e

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

# Always ask for password
echo -n Password: 
read -r -s password
echo

# TODO: check if JIRA_SESSION_ID is set/valid
jiraAuth.sh "$username" "$password"

curl -s "$JIRA_URL/jira/rest/api/2/search" -b JSESSIONID="${JIRA_SESSION_ID}" -H "Content-type: application/json" -X POST -d "{\"jql\": \"issueFunction in commented (\\\"by $username\\\") AND updatedDate > $updatedDate\" }" | jq -r '.issues[] | .key + " ~ " + .fields.summary + " ~ " + .fields.status.name'
