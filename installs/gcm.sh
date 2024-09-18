#!/usr/bin/env bash
set -euo pipefail

cleanup() {
    echo "Cleaning up..."
    rm -f "$DEB_FILE"
}
trap cleanup EXIT

ASSETS_URL="$(curl -s https://api.github.com/repos/git-ecosystem/git-credential-manager/releases/latest | jq -r '.assets_url')"

DOWNLOAD_URL="$(curl -s "$ASSETS_URL" | jq -r '.[] | select(.name | test("^gcm-linux_amd64.*\\.deb$")) | .browser_download_url')"

if [[ -z "$DOWNLOAD_URL" ]]; then
    echo "Failed to find the .deb package download URL"
    exit 1
fi

TEMP_DIR="/tmp"
DEB_FILE="$TEMP_DIR/$(basename "$DOWNLOAD_URL")"

curl -s -Lo "$DEB_FILE" "$DOWNLOAD_URL"

sudo apt install "$DEB_FILE"

# Should I verify the signature?
# https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/linux-validate-gpg.md#debian-package

#
# Code below is for isntalling gcm with dotnot. It is the preferred
# way according to the documentation but this currently forces the use of 
# dotnot 7.0 which is EOL.
#

## Should I used the scripted installation instead?
## https://learn.microsoft.com/en-us/dotnet/core/install/linux-scripted-manual#scripted-install
#
## Since dotnet 7 is required for GCM, we need to install the dotnet backports library:
#sudo add-apt-repository -y ppa:dotnet/backports
## https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#supported-distributions
## https://github.com/git-ecosystem/git-credential-manager/issues/1702
#
#sudo apt install -y dotnet-sdk-7.0
#
#dotnet tool install -g git-credential-manager
#git-credential-manager configure
