#!/usr/bin/env bash
set -euo pipefail

# Install chrome (installation procedure copied from vscode.sh)
curl -fsSL https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > packages.google.gpg
sudo install -D -o root -g root -m 644 packages.google.gpg /etc/apt/keyrings/packages.google.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.google.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
rm -f packages.google.gpg

sudo apt update
sudo apt install -y google-chrome-stable

# https://askubuntu.com/questions/1063331/how-to-install-google-chrome-extensions-though-terminal

install_chrome_extension () {
  preferences_dir_path="$HOME/.config/google-chrome/Default/Extensions"
  pref_file_path="$preferences_dir_path/$1.json"
  upd_url="https://clients2.google.com/service/update2/crx"
  mkdir -p "$preferences_dir_path"
  printf '{\n  "external_update_url": "%s"\n}\n' "$upd_url" > "$pref_file_path"
  echo Added \""$pref_file_path"\" ["$2"]
}

install_chrome_extension "cjpalhdlnbpafiamejdnhcphjbkeiagm" "uBlock Origin"
install_chrome_extension "fihnjjcciajhdojfnbdddfaoknhalnja" "I don't care about cookies"
install_chrome_extension "nngceckbapebfimnlniiiahkandclblb" "Bitwarden"