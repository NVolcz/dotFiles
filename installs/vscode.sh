#!/usr/bin/env bash
set -euo pipefail

# For vscode
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

