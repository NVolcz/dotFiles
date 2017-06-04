#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset


#
# Preparations
#
dotfiles_folder=$(readlink -f $(dirname $0))
arch="x64"
os=$(uname -s)

# How do I make this crossplatform?
cygman=$USERPROFILE/programs/cygman.exe

source $dotfiles_folder/.common.sh

#
# Package check
#

packages_to_install=""

function installPackage() {
	cmd=$1
	if [ $# -eq 2 ] ; then
		pkgName=$2
	else
		pkgName=$cmd
	fi

	if ! command_exists $cmd ; then
		packages_to_install="$packages_to_install $pkgName"
	fi
}

# Packages
installPackage dos2unix
installPackage ssh openssh
installPackage zip
installPackage unzip
installPackage tmux

# Install packages
if [ -n "$packages_to_install" ]; then
	$cygman -q -W -P $packages_to_install
fi

#
# Symlinks
#

# folders
ln -sf $USERPROFILE ~/winhome
ln -sf $USERPROFILE/gits ~/gits
ln -sf $USERPROFILE/programs ~/bin

# dotfiles

ln -sf $dotfiles_folder/.bashrc ~/.bashrc
ln -sf $dotfiles_folder/.common.sh ~/.common.sh
ln -sf $dotfiles_folder/.gitconfig ~/.gitconfig
ln -sf $dotfiles_folder/.inputrc ~/.inputrc
ln -sf $dotfiles_folder/.lesskey ~/.lesskey
ln -sf $dotfiles_folder/.tmux.conf.txt ~/.tmux.conf.txt
ln -sf $dotfiles_folder/.vim ~/.vim

