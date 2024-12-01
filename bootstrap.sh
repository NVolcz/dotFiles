#!/usr/bin/env bash
set -euo pipefail

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
# fontconfig - required for source code pro install
# exuberant-ctags - used for generating ctags for vim setup
other_software="wget \
  fontconfig \
  exuberant-ctags"

# Install packages
sudo apt-get update -q
# shellcheck disable=SC2086
sudo apt-get install -q -y $required_software $bashrc_software $other_software

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
mkdir -p ~/dotfiles_old

dotfiles_dir="$HOME/git/dotFiles"
config_dir="$dotfiles_dir/config"

function linkDotFiles() {
  local src_dir=$1
  local dest_dir=$2
  local prefix=${3-"."}

  for file in $src_dir/*; do
    local file="$(basename $file)"
    local src="$src_dir/$file"
    local dest="$dest_dir/$prefix$file"

    # Directories are special. Re-use existing directories when possible
    if [[ -d "$src" ]]; then
      if [[ ! -d "$dest" ]]; then
        mkdir "$dest"
        linkDotFiles "$src" "$dest" ""
      else
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

# I could put the files in "bin" under "config/local/bin" but that would
# mix configuration files with scripts so I think it is wise 
if [[ ! -d "$HOME/.local/bin" ]]; then
  mkdir -p "$HOME/.local/bin"
fi
linkDotFiles "$dotfiles_dir/bin" "$HOME/.local/bin" ""
