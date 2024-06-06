#!/usr/bin/env bash
set -euo pipefail

# BETLOG - 2018-03-31--19-48-34
# based on https://gist.github.com/jbgo/5016064

echo -ne "CAUTION::\\nThis script apt-get removes all but the currently operational kernel\\n"

read -p "Continue? (y/n)?" -r answer
case ${answer:0:1} in
y | Y)
  sudo -v
  current=$(uname -r)
  available=$(dpkg -l | grep "ii" | grep -Po "linux-image\S*generic")
  remove=()
  for name in $available; do
    if [[ ${name/$current/} == ${name} ]]; then
      remove+=("$name")
    fi
  done
  sudo apt-get remove ${remove[@]}
  sudo apt-get autoremove
  echo FINISHED
  ;;
*)
  echo ABORTING
  ;;
esac
