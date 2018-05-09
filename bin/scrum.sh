#!/usr/bin/env bash
set -e

if [ "$#" -gt 2 ]; then
    echo "Illegal number of parameters"
    exit 1
fi

# Username
if [ "$#" -eq 0 ]; then
    echo -n Username: 
	read -s username
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
read -s password
echo

jira_auth_uri="/jira/rest/auth/latest/session"

# Authenticate
session_id=$(curl -s -H "Content-Type: application/json" -d "{\"username\":\"${username}\",\"password\":\"${password}\"}" -X POST $JIRA_URL$jira_auth_uri | sed -r 's/^.+JSESSIONID","value":"([^"]+).+$/\1/ig')

if [[ -n $(echo $session_id | grep error) ]]
then
	echo "Wrong login or password!"
	exit 1
fi

curl -s $JIRA_URL/jira/rest/api/2/search -b JSESSIONID=${session_id} -H "Content-type: application/json" -X POST -d "{\"jql\": \"issueFunction in commented (\\\"by $username\\\") AND updatedDate > $updatedDate\" }" | jq -r '.issues[] | .key + " ~ " + .fields.summary + " ~ " + .fields.status.name'