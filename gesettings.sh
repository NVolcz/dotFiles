#!/usr/bin/env bash
set -euo pipefail

gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.interface clock-show-date '24h'
gsettings set org.gnome.desktop.interface clock-show-seconds false

gsettings set org.gnome.desktop.calendar show-weekdate true
