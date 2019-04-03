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

dotfiles_dir="$HOME/git/dotFiles"
config_dir="$dotfiles_dir/config"
files=$(find "$config_dir" -maxdepth 1 -type f)

function linkDotFiles {
  local src_dir=$1
  local dest_dir=$2
  local prefix=${3-"."}

  for file in $src_dir/*; do
    local file="$(basename $file)"
    local src="$src_dir/$file"
    local dest="$dest_dir/$prefix$file"

    # Directories are special...
    if [[ -d "$src" ]]; then
      if [[ "$file" -eq "config" ]]; then
        linkDotFiles "$src" "$dest" ""
        continue
      fi
    fi

    if [[ -f "$dest" ]]; then
      if [[ ! "$src" -ef "$dest" ]]; then
        mv "$dest" ~/dotfiles_old/
      fi
      continue
    fi

    ln -s "$src" "$dest"
  done
}

linkDotFiles "$dotfiles_dir/config" "$HOME"
