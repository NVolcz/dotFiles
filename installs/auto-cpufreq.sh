#!/usr/bin/env bash
set -euo pipefail

# From: https://github.com/AdnanHodzic/auto-cpufreq/releases.atom

cd $HOME/git
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer -y
