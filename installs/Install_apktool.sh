#!/usr/bin/env bash
set -e

# Get latest version from https://bitbucket.org/iBotPeaches/apktool/downloads
APKTOOL_VERSION=2.3.3
JAR_DEST_FILE="$HOME/.local/bin/apktool.jar"
WRAPPER_DEST_FILE="$HOME/.local/bin/apktool"

wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_$APKTOOL_VERSION.jar -O "$JAR_DEST_FILE"
wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O "$WRAPPER_DEST_FILE"
chmod +x $WRAPPER_DEST_FILE