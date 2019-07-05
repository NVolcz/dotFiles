#!/usr/bin/env bash
set -euo pipefail

# TODO currently there are less than 999 advisories so there is no need to implement paging.
response=$(curl -s "https://www.npmjs.com/advisories?page=0&perPage=999" -H "x-spiferack: 1")

echo "$response" | jq '[ .advisoriesData.objects[] | select(.title == "Malicious Package") ] | length'
