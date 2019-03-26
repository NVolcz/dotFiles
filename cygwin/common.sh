#!/usr/bin/env bash
set -euo pipefail

command_exists() {
  type "$1" >/dev/null 2>&1
}
