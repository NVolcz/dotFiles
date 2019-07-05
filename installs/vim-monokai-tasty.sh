#!/usr/bin/env bash
set -euo pipefail

cd $HOME/git
git clone https://github.com/patstockwell/vim-monokai-tasty.git
cd vim-monokai-tasty

ln -s $PWD/colors/vim-monokai-tasty.vim $HOME/.vim/colors/vim-monokai-tasty.vim
