#!/usr/bin/env bash
set -euo pipefail

# For vscode (from: https://code.visualstudio.com/docs/setup/linux)
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install code

code --install-extension eamodio.gitlens

# This plugin does no longer work with podman: https://github.com/microsoft/vscode-docker/issues/3766
code --install-extension ms-azuretools.vscode-docker

# TODO: Replace if there ever is a plugin that integrates to the official test API.
# See: https://github.com/hbenl/vscode-mocha-test-adapter/issues/184
code --install-extension hbenl.vscode-mocha-test-adapter

code --install-extension dbaeumer.vscode-eslint

code --install-extension streetsidesoftware.code-spell-checker

code --install-extension mechatroner.rainbow-csv

echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
