#!/usr/bin/env bash
set -euo pipefail

# Pre-requisites:
# az extension add --name 'azure-devops'

# You can configure default org:
# az devops configure --defaults organization=https://dev.azure.com/MyOrganization/

if [ $# -ne 2 ]; then
  echo "Invalid arguments!"
  exit 1
fi

ORG="$1"
PROJECT="$2"

az repos list --org "$ORG" --project "$PROJECT" | jq -r '.[].remoteUrl' |
  while read repo; do
    git clone "$repo"
  done
