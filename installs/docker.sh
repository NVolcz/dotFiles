#!/usr/bin/env bash

# Install Docker (https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository -y \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt install -y docker-ce

