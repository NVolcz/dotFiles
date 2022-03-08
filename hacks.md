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

## Fix end-of-line in Git repository
```git ls-tree --full-tree -r --name-only HEAD | head -n 3 | tee /dev/tty | xargs -I{} sed -i -e '$a\' {}```
