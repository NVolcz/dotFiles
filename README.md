# dotFiles

### Run with docker
Build the Dockerfile with:

```
$ docker build -t nvolcz/dotfiles .
```

Build without caching the bootstrap sequence:
```
$ docker build -t nvolcz/dotfiles . --build-arg CACHE_DATE=$(date +%Y-%m-%d:%H:%M:%S)
```

Run it:

```
$ docker run -it nvolcz/dotfiles /bin/bash
```

Combined:
`sudo docker build -t nvolcz/dotfiles . && sudo docker run -it nvolcz/dotfiles /bin/bash`
### Tests

```
./test.sh
```


