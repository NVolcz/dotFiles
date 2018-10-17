#!/usr/bin/env bash
set -e
set -o pipefail

# Borrowed from https://github.com/jessfraz/dotfiles/blob/master/test.sh

ERRORS=()

# find all executables and run `shellcheck`
for f in $(find . -type f -not -path './cygwin/*' -not -iwholename '*.git*' | sort -u); do
	if (file "$f" | grep --quiet shell); then
		{
			shellcheck "$f" --color="${1:-auto}" && echo "[OK]: sucessfully linted $f"
		} || {
			# add to errors
			ERRORS+=("$f")
		}
	fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
	echo "No errors, hooray"
else
	echo "These files failed shellcheck: ${ERRORS[*]}"
	exit 1
fi
