#!/bin/bash

# From: https://movingtothedarkside.wordpress.com/2015/01/10/clone-all-repositories-from-a-user-bitbucket/
# Script to get all repositories under a user from bitbucket
# Usage: getAllRepos.sh [username]
# source: http://haroldsoh.com/2011/10/07/clone-all-repos-from-a-bitbucket-source/

if [ $# -eq 2 ]; then
	username="$1"
	team="$2"
	url="https://api.bitbucket.org/1.0/users/${1}"
	echo "not supported yet..."
	exit 1
elif [ $# -eq 3 ]; then
	username="$1"
	team="$3"
	url="https://$2/rest/api/1.0/projects/$3/repos"
else
	echo "Invalid arguments!"
	exit 1
fi



response=$(curl -s -H "Accept: application/json" -u "${username}" "${url}")

for repo_name in $(echo $response | jq -r '.values[].links.clone[] | select(.name == "ssh") | .href')
do
    echo "Cloning $repo_name"
    
    git clone "$repo_name"
    echo "---"
done