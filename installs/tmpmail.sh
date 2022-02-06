#!/usr/bin/env bash
set -euo pipefail

# https://github.com/sdushantha/tmpmail

# Download the tmpmail file and make it executable
curl -L "https://git.io/tmpmail" > tmpmail && chmod +x tmpmail

# Then move it somewhere in your $PATH. Here is an example:
mv tmpmail ~/.local/bin/
