#!/usr/bin/env bash
#set -euo pipefail

#
# TODO:
# - Add bitbucket auth
#

jira_auth() {
  if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    return 1
  elif [ -z "$JIRA_URL" ]; then
    echo "JIRA_URL needs to be set"
    return 1
  fi

  if [ -n "${JIRA_SESSION_ID:-}" ]; then
    # TODO: test if session is valid
    # curl $JIRA_URL/jira/rest/auth/1/session -b JSESSIONID=${JIRA_SESSION_ID} -v
    echo "Reuse Jira session ID"
    return 0
  fi

  # TODO: Add support for getting username and password from keyring

  username="$1"
  password="$2"

  jira_auth_uri="$JIRA_URL/jira/rest/auth/1/session"

  # Authenticate
  login_response=$(curl -s -H "Content-Type: application/json" -d "{\"username\":\"${username}\",\"password\":\"${password}\"}" -X POST "$jira_auth_uri")

  JIRA_SESSION_ID=$(echo "$login_response" | jq -r '.session.value')

  export JIRA_SESSION_ID="$JIRA_SESSION_ID"
}