# Bluetooth

https://www.redpill-linpro.com/techblog/2021/05/31/better-bluetooth-headset-audio-with-msbc.html

# Audio

Archwiki is awesome:
https://wiki.archlinux.org/title/PipeWire
https://wiki.archlinux.org/title/WirePlumber

Gentoo wiki is also refered to from the pipewire Git repo:
https://wiki.gentoo.org/wiki/Pipewire

Wireplumber configuration: https://pipewire.pages.freedesktop.org/wireplumber/configuration.html

Pipewire configuration:
https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/Config-PipeWire#configuration-file-pipewireconf

PipeWire wiki
https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/home

Verifying that PipeWire is being used:
`pactl info | grep "Server Name"`

Changes that I made to ~/.config/pipewire/pipewire.conf:
`default.clock.allowed-rates = [48000 44100 96000]`

Command to read logs:
`journalctl -u pipewire -u pipewire-pulse -u wireplumber -u bluetooth -f`


`Failed to set scheduler settings: Operation not permitted`
https://gitlab.freedesktop.org/pipewire/wireplumber/-/issues/255


Nice read:
[](https://gjhenrique.com/pipewire/)

Error: `Unable to get Hands-Free Voice gateway SDP record`
https://github.com/bluez/bluez/issues/159

TODO:
- What is no AVRCP? (https://wiki.archlinux.org/title/Bluetooth_headset#Apple_AirPods_have_low_volume)

How to get bluetooth debug logs:
```
sudo systemctl mask --runtime bluetooth.service
sudo systemctl stop bluetooth.service
sudo /usr/libexec/bluetooth/bluetoothd -n -d '*' 2>&1 | tee bluetooth.log
```

[The PipeWire in 22.04 and 22.10 both has aptX and AAC disabled at compile time](https://gist.github.com/the-spyke/2de98b22ff4f978ebf0650c90e82027e?permalink_comment_id=4346694#gistcomment-4346694)
Anna Glasgall has created a PPA for PipeWire with aptX and AAC enabled:
```
sudo add-apt-repository ppa:aglasgall/pipewire-extra-bt-codecs
sudo apt update
```

There's a lot of debate as to whether higher sampling rates improve sound quality (TL;DR: stick with 44K):
https://www.mojo-audio.com/blog/the-24bit-delusion/
https://web.archive.org/web/20200418033300/http://people.xiph.org/~xiphmont/demo/neil-young.html

Good read: https://habr.com/en/post/456182/

# Less syntax highlightning
The most common way to implement syntax highlightning in less is by piping the buffer through source-highlight
using the LESSOPEN environment variable.
```
export LESSOPEN="|-/path/to/src-hilite-lesspipe.sh %s"
export LESS=-R
```
It is however annoying to have to keep the colors up-to-date between different tools, vscode, vim, less etc. 
TODO: Investigate if there is a "standard" way to highlight source code for my tooling.
One way would be to contribute an [source-highlight color config](https://www.gnu.org/software/src-highlite/source-highlight.html#Output-format-style) to the [vim-monokai-tasty repo](https://github.com/patstockwell/vim-monokai-tasty/).
- What is no AVRCP? (https://wiki.archlinux.org/title/Bluetooth_headset#Apple_AirPods_have_low_volume)

