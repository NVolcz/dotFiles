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
# fontconfig - required for source code pro install
# exuberant-ctags - used for generating ctags for vim setup
other_software="wget \
  rsync \
  fontconfig \
  exuberant-ctags"

# Install packages
apt-get update -q
# shellcheck disable=SC2086
apt-get install -q -y $required_software $bashrc_software $other_software

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
mkdir -p ~/dotfiles_old

dotfiles_dir="$HOME/git/dotFiles"
config_dir="$dotfiles_dir/config"
files=$(find "$config_dir" -maxdepth 1 -type f)

function linkDotFiles() {
  local src_dir=$1
  local dest_dir=$2
  local prefix=${3-"."}

  for file in $src_dir/*; do
    local file="$(basename $file)"
    local src="$src_dir/$file"
    local dest="$dest_dir/$prefix$file"

    # Directories are special...
    if [[ -d "$src" ]]; then
      if [[ ! -d "$dest" ]]; then
        # Not sure this is the correct action to take here...
        # Maybe I should link to the dotFiles directory instead of creating a new one...
        mkdir "$dest"
        linkDotFiles "$src" "$dest" ""
      else
        linkDotFiles "$src" "$dest" ""
      fi

      # TODO: Make sure that this is git/dotFiles/config/config and not another config directory...
      if [[ "$file" == "config" ]]; then
        linkDotFiles "$src" "$dest" ""
      fi
      continue
    fi

    if [[ -f "$dest" ]]; then
      if [[ "$src" -ef "$dest" ]]; then
        # Maybe it is better to add -f to ln?
        rm "$dest"
      else
        mv "$dest" ~/dotfiles_old/
      fi
    elif [[ -L "$dest" ]]; then
      # This if-statement is to check if a symlink exist but is broken.
      # Maybe it is better to add -f to ln?
      rm "$dest"
    fi

    ln -s "$src" "$dest"
  done
}

linkDotFiles "$dotfiles_dir/config" "$HOME"
