#!/usr/bin/env bash
set -euo pipefail

TEMP_DEB="$(mktemp).deb" &&
  wget -O "$TEMP_DEB" 'http://downloads.dlang.org/releases/2.x/2.085.0/dmd_2.085.0-0_amd64.deb' &&
  apt install -y $TEMP_DEB
rm -f "$TEMP_DEB"
