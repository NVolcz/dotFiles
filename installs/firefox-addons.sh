#!/usr/bin/env bash
set -euo pipefail

# TODO: This is only semi-automated so far...

# I don't care about cookies
#install_addon "https://addons.mozilla.org/firefox/downloads/file/4022610/" "i-dont-care-about-cookies"
firefox "https://addons.mozilla.org/firefox/downloads/file/4022610/"

# Bitwarden
#install_addon "https://addons.mozilla.org/firefox/downloads/file/4018008/" "bitwarden"
firefox "https://addons.mozilla.org/firefox/downloads/file/4018008/"

# uBlock Origin
#install_addon "https://addons.mozilla.org/firefox/downloads/file/4028976/" "ublock-origin"
firefox "https://addons.mozilla.org/firefox/downloads/file/4028976/"

# Swedish Dictionary
firefox "https://addons.mozilla.org/firefox/downloads/file/3539390/"

# TODO: Find a way to install other Firefox configurations:
# Disable "mute tab"-button - browser.tabs.showAudioPlayingIcon false
# Disable firefox password manager - sigon.rememberSignons false


# Firefox settings:
# privacy.trackingprotection.enabled - true
# https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration

# signon.rememberSignons;false - Disable Firefox password manager.
# browser.tabs.closeWindowWithLastTab;false - Do not close Firefox when the last tab is closed.
# browser.quitShortcut.disabled;false - https://blog.wxm.be/2021/08/18/firefox-finally-lets-you-disable-ctrl-q.html