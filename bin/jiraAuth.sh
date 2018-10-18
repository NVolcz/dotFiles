#!/usr/bin/env bash
set -euo pipefail

#
# TODO:
# - Add bitbucket auth
#

if [ "$#" -ne 2 ]; then
  echo "Illegal number of parameters"
  exit 1
elif [ -z "$JIRA_URL" ]; then
  echo "JIRA_URL needs to be set"
  exit 1
fi

username="$1"
password="$2"

jira_auth_uri="/jira/rest/auth/latest/session"

# Authenticate
JIRA_SESSION_ID=$(curl -s -H "Content-Type: application/json" -d "{\"username\":\"${username}\",\"password\":\"${password}\"}" -X POST "$JIRA_URL$jira_auth_uri" | sed -r 's/^.+JSESSIONID","value":"([^"]+).+$/\1/ig')

if echo "$JIRA_SESSION_ID" | grep -q error; then
  echo "Wrong login or password!"
  exit 1
fi

export JIRA_SESSION_ID
echo "$JIRA_SESSION_ID"
