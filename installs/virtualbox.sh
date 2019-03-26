#!/usr/bin/env bash

# Install VirtualBox
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | apt-key add -
apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib"

apt install -y virtualbox-6.0

