#!/usr/bin/env bash
set -euo pipefail

# Inspired by: https://github.com/jessfraz/dotfiles/blob/master/test.sh

ERRORS=()

input=("$@")

if ! command -v shellcheck &> /dev/null
then
    echo "shellcheck is not installed!"
    exit 1
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
  exit 0
else
  echo "These files failed shellcheck: ${ERRORS[*]}"
  exit 1
fi
