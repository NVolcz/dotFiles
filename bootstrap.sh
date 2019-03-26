#!/usr/bin/env bash
set -euo pipefail

# VARIABLES
dotfiles_folder="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"

# The script assumes root for installing packages (and stuff)
if [ $UID != 0 ]; then
  echo "You don't have sufficient privileges to run this script."
  exit 1
fi

# Software required for the bootstrap
required_software="apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg"

bashrc_software="source-highlight \
    man \
    vim\
    git\
    trash-cli"

# wget - Used by installs/apktool.sh
# rsync - installs/gitkraken_64.sh
other_software="wget \
rsync"

# Install packages
apt-get update
# shellcheck disable=SC2086
apt-get install -y $required_software $bashrc_software $other_software

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
