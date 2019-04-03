#!/usr/bin/env bash


# Install sublime text (https://www.sublimetext.com/docs/3/linux_repositories.html)
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" > /etc/apt/sources.list.d/sublime-text.list

apt update && apt install -y sublime-text

