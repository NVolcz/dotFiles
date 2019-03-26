.PHONY: test lint-dockerfile build-docker build-docker-no-cache run-docker

BASH_SCRIPTS = $(shell find . -iname '*.sh' -not -path './cygwin/*')

test:
	./test/shellcheck.sh $(BASH_SCRIPTS)
	./test/check-safe-bash.sh $(BASH_SCRIPTS)

lint-dockerfile:
	docker run --rm -i hadolint/hadolint < Dockerfile

build-docker:
	docker build -t nvolcz/dotfiles .

build-docker-no-cache:
	docker build -t nvolcz/dotfiles . --build-arg CACHE_DATE=$(date +%Y-%m-%d:%H:%M:%S)

run-docker:
	docker run -it nvolcz/dotfiles /bin/bash

test-docker:
	docker run -it nvolcz/dotfiles /bin/bash -c 'cd /root/git/dotFiles/; ./test/docker-test.sh'
