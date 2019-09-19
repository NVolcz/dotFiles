export SHELL:=/bin/bash
export SHELLOPTS:=$(if $(SHELLOPTS),$(SHELLOPTS):)pipefail:errexit

.ONESHELL:

.PHONY: test lint-dockerfile build-docker-no-cache

BASH_SCRIPTS = $(shell find . -iname '*.sh' -not -path './cygwin/*')

test:
	./test/shellcheck.sh $(BASH_SCRIPTS)
	./test/check-safe-bash.sh $(BASH_SCRIPTS)

format-scripts:
	shfmt -i 2 -w $(BASH_SCRIPTS)

lint-dockerfile:
	docker run --rm -i hadolint/hadolint < Dockerfile

build-docker: Dockerfile $(BASH_SCRIPTS)
	docker build -t nvolcz/dotfiles .

build-docker-no-cache:
	docker build -t nvolcz/dotfiles . --build-arg CACHE_DATE=$(date +%Y-%m-%d:%H:%M:%S)

run-docker:
	docker run -it nvolcz/dotfiles /bin/bash

run-docker-mount-volume:
	docker run -v $PWD:/root/git/dotFiles -it nvolcz/dotfiles bash

test-docker: build-docker
	CONTAINER_ID=$(shell docker run -t -d nvolcz/dotfiles)
	@echo $$CONTAINER_ID
	trap 'docker kill $$CONTAINER_ID' EXIT
	docker exec -it $$CONTAINER_ID \
	bash -c 'cd /root/git/dotFiles; ./test/docker-test.sh'

