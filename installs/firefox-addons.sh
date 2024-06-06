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
