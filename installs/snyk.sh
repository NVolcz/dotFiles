#!/usr/bin/env bash

curl https://static.snyk.io/cli/latest/snyk-linux -o snyk
chmod +x ./snyk
mv ./snyk $HOME/.local/bin
