# Bash hacks

## Pipe std streams
`command 2>&1 | another-command`

# Hacks

## Install local CA for pip
1. Copy cert to `/usr/local/share/ca-certificates/`
2. sudo update-ca-certificates
3. Add these lines to `~/.config/pip/pip.conf` \
```
[global]
cert=/etc/ssl/certs/ca-certificates.crt
```

## Performance metrics with curl

Source: https://stackoverflow.com/a/22625150

curl-format.txt:
```
time_namelookup:  %{time_namelookup}s\n
time_connect:  %{time_connect}s\n
time_appconnect:  %{time_appconnect}s\n
time_pretransfer:  %{time_pretransfer}s\n
time_redirect:  %{time_redirect}s\n
time_starttransfer:  %{time_starttransfer}s\n
----------\n
time_total:  %{time_total}s\n
```

Command: `curl -w "@curl-format.txt" -o /dev/null -s "http://wordpress.com/"`

## Fix missing newline EOF in Git repository
```git ls-tree --full-tree -r --name-only HEAD | head -n 3 | tee /dev/tty | xargs -I{} sed -i -e '$a\' {}```

From [Stackoverflow](https://stackoverflow.com/a/57770973):
```for f in $(git grep --cached -Il ''); do tail -c1 $f | read -r _ || echo >> $f; done```

## Download apt package and dependencies
Useful for installing a package on a computer without network.
Borrowed from: https://stackoverflow.com/a/27469489

Download:
```
apt-get download $(apt-rdepends <package>|grep -v "^ " |grep -v "^libc-dev$")
```

Install:
```
sudo dpkg -i *.deb
```

## Copy image to clipboard
`xclip -selection clipboard -t image/png -i example.png`


## mandb trigger taking forever

1. Empty man-db cache: `sudo mandb -t && sudo rm -rf /var/cache/man/ && sudo mandb -c`
2. `sudo dpkg -- configure -a`