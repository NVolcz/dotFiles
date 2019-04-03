#!/usr/bin/env bash

# Test bootstrap.sh

./bootstrap.sh

if [ $? -ne 0 ]; then
  echo "Error running bootstrap.sh"
  exit 1
fi

# Test running bootstrap.sh a second time to test update mechanism

./bootstrap.sh
if [ $? -ne 0 ]; then
  echo "Error updating system with bootstrap.sh"
  exit 1
fi


for f in $(find installs -type f | sort -u); do
  echo "Running $f"
  source $f
  if [ $? -ne 0 ]; then
    echo "Failed to run $f"
    exit 1
  fi
done
