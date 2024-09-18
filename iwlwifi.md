
It is possible to configure iwlwifi by adding options to `/etc/modprobe.d/iwlwifi.conf`.

I have seen people suggest to try and evaluate these options:
```
options iwlwifi 11n_disable=1
options iwlwifi 11n_disable=8
```

Don't forget to remove iwlmvm when reloading:
```
sudo modprobe -r iwlmvm
sudo modprobe -r iwlwifi
sudo modprobe iwlwifi
```

`sudo modinfo iwlwifi` for showing params (and other stuff).

for checking the running hardware:
```
lspci | grep -i network
sudo lshw -C network
```

https://forum.manjaro.org/t/wifi-network-speed-intel-wireless-7265-driver-iwlwifi/154472/6