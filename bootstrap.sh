#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

# VARIABLES
dotfiles_folder="$(readlink -f $(dirname "${BASH_SOURCE[0]}"))"

# The script assumes root for installing packages (and stuff)
if [ $UID != 0 ]; then
    echo "You don't have sufficient privileges to run this script."
    exit 1
fi

# Install packages
apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg \
    source-highlight \
    man \
    vim

# Install sublime text (https://www.sublimetext.com/docs/3/linux_repositories.html)
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

# Install Docker (https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Install chrome
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Update the newly added repos and install docker and sublime-text
apt-get update
apt-get install -y \
    docker-ce \
    sublime-text \
    google-chrome-stable

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
mkdir -p ~/dotfiles_old

files=$(ls "$dotfiles_folder/config") 
for file in $files; do
    dest="$HOME/.$file"
    src="$dotfiles_folder/config/$file"

    if [[ -f "$dest" ]]; then
	mv "$dest" ~/dotfiles_old/
    fi

    ln -s "$src" "$dest"
done

if [ ! "$(ls -A ~/dotfiles_old)" ]; then
    rm -r ~/dotfiles_old
fi
