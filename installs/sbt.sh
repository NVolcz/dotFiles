#!/usr/bin/env bash
set -euo pipefail

# The script assumes root for installing packages (and stuff)
if [ $UID != 0 ]; then
  echo "You don't have sufficient privileges to run this script."
  exit 1
fi

# From: https://www.scala-sbt.org/download.html

echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | sudo tee /etc/apt/sources.list.d/sbt.list
echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | sudo tee /etc/apt/sources.list.d/sbt_old.list
curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
sudo apt-get update
sudo apt-get install sbt
