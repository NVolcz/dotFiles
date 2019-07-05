#!/usr/bin/env bash
set -euo pipefail

SHORTCUT="[Desktop Entry]
Name=Git Kraken
Exec=/usr/local/GitKraken/gitkraken
Terminal=false
Type=Application
Categories=Git
Terminal=false
Type=Application
Encoding=UTF-8
Categories=Utility;TextEditor;"
#Icon=/usr/local/sublime-text-3/Icon/128x128/sublime_text.png

wget https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz
tar -xvzf gitkraken-amd64.tar.gz
rsync -va --delete-after gitkraken/ /usr/local/GitKraken/
echo "${SHORTCUT}" >"/usr/share/applications/gitkraken.desktop"
