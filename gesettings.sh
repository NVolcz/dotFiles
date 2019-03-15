#!/usr/bin/env bash
set -euo pipefail

gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds false

gsettings set org.gnome.desktop.calendar show-weekdate true

gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']" 
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']" 
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']" 
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']" 
