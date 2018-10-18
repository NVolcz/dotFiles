#!/bin/sh
set -euo pipefail

SHORTCUT="[Desktop Entry]
  Encoding=UTF-8
  Name=xflux
  Comment=Adapts screen color temperature according to daytime
  Exec=/home/<user>/.local/bin/xflux -l 59 -g 18
  Terminal=false
  Type=Application"

wget https://justgetflux.com/linux/xflux64.tgz
tar -xvzf xflux64.tgz
rsync -va --delete-after xflux /usr/local/xflux/
echo "${SHORTCUT}" >"/usr/share/applications/xflux.desktop"
