#!/usr/bin/env bash
set -euo pipefail

# For vscode (from: https://code.visualstudio.com/docs/setup/linux)
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install code

code --install-extension eamodio.gitlens

# This plugin does no longer work with podman: https://github.com/microsoft/vscode-docker/issues/3766
code --install-extension ms-azuretools.vscode-docker

code --install-extension ms-vscode.makefile-tools
# TODO: Replace if there ever is a plugin that integrates to the official test API.
# See: https://github.com/hbenl/vscode-mocha-test-adapter/issues/184
code --install-extension hbenl.vscode-mocha-test-adapter


# Prefer ronnidc.nunjucks over eseom.nunjucks-template for now.
# They seem very similar but ronnidc seems:
# - More active on Github
# - more lightweight (it is basically only TextMate syntax files packaged as a vscode extension)
# On the other hand:
# - TextMate, is it really a good way to implement syntax highlighting?
# - It is only a single dependency.
# - ronnidc does currently not have a license (See issues #33)
code --install-extension ronnidc.nunjucks

code --install-extension dbaeumer.vscode-eslint

# TODO:
# Add ` --enable-features=UseOzonePlatform --ozone-platform=wayland` 
# to /usr/share/applications/code.desktop