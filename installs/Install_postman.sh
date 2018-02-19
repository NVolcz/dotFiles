#!/usr/bin/env bash

set -e

# The script assumes root for installing packages (and stuff)
if [ $UID != 0 ]; then
    echo "You don't have sufficient privileges to run this script."
    exit 1
fi

#
# Borrowed from: https://blog.bluematador.com/posts/postman-how-to-install-on-ubuntu-1604/
#

wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
tar -xzf postman.tar.gz -C /opt
rm postman.tar.gz
ln -sf /opt/Postman/Postman /usr/bin/postman

cat > ~/.local/share/applications/postman.desktop <<EOL
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=postman
Icon=/opt/Postman/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
EOL
