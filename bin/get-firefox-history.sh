#!/usr/bin/env bash
set -euo pipefail

db=$(find "${HOME}/.mozilla/firefox/" -name "places.sqlite")
tmp_file="$(mktemp -d)/places.sqlite"
cp "$db" "$tmp_file"
query="select p.url from moz_historyvisits as h, moz_places as p where p.id == h.place_id order by h.visit_date;"
todays_urls=$(sqlite3 "${tmp_file}" "${query}")
echo "${todays_urls}" > todays_urls
