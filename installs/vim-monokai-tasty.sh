#!/usr/bin/env bash
set -euo pipefail

cd $HOME/git

if [ -d "vim-monokai-tasty" ]; then
  cd vim-monokai-tasty
  git pull
else
  git clone https://github.com/patstockwell/vim-monokai-tasty.git
  cd vim-monokai-tasty
fi

# The parent dir should exist
mkdir "$HOME/.vim/colors/"

ln -s "$PWD/colors/vim-monokai-tasty.vim" "$HOME/.vim/colors/vim-monokai-tasty.vim"
