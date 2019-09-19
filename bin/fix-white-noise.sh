#!/usr/bin/env bash
set -euo pipefail

# Not sure if this is needed...
#rm -r ~/.config/pulse /tmp/pulse-*
#pulseaudio -k && sudo alsa force-reload && pulseaudio --start

# Found at: https://wiki.archlinux.org/index.php/Dell_XPS_13_(9360)#Continuous_hissing_sound_with_headphones
amixer -c PCH cset 'name=Headphone Mic Boost Volume' 1
