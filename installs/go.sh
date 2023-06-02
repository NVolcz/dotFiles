#!/usr/bin/env bash
set -euo pipefail

# Inspired by:
# https://gist.github.com/Zate/b3c8e18cbb2bbac2976d79525d95f893?permalink_comment_id=3991787#gistcomment-3991787

REM_VER=$(curl -s https://go.dev/VERSION?m=text)
#REM_VER=$(wget -qO- https://go.dev/dl/ | grep 'id=\"go' | head -1 | grep -oP -e '(go[0-9\.]+)')
sudo rm -rf /usr/local/go
wget -qO- https://golang.org$( wget -qO- https://golang.org/dl/ | grep -oP '/dl/go([0-9\.]+)\.linux-amd64.tar.gz' | head -1)  | sudo tar zxf - -C /usr/local