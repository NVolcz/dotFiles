#!/usr/bin/env bash
set -euo pipefail

# Borrowed from https://github.com/jessfraz/dotfiles/blob/master/test.sh

ERRORS=()

if [[ $# -eq 0 ]]; then
	input="$(find . -type f -not -path './cygwin/*' -not -iwholename '*.git*' \
	-exec sh -c 'file -b "$1" | grep -q "shell"' sh {} \; -print)"
else
	input=("$@")
fi
# Sort input magic
readarray -t input < <(printf '%s\n' "${input[@]}" | sort)

for f in "${input[@]}"; do
 {
   shellcheck "$f" --color=always && echo "[OK]: sucessfully linted $f"
 } || {
   # add to errors
   ERRORS+=("$f")
 }
done

if [ ${#ERRORS[@]} -eq 0 ]; then
  echo "No errors, hooray"
else
  echo "These files failed shellcheck: ${ERRORS[*]}"
fi

