#!/usr/bin/env bash
set -e

# From: https://www.scala-sbt.org/1.0/docs/Installing-sbt-on-Linux.html
	

URL="https://data.services.jetbrains.com/products/download?code=IIC&platform=linux"
TAR_PATH="/tmp/intellij.tar.gz"
INSTALL_PATH="$HOME/bin/"

wget -O $TAR_PATH $URL

tar xvf $TAR_PATH -C $INSTALL_PATH

# TODO: Add ln -s for $HOME/bin/idea