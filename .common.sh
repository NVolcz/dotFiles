#!/usr/bin/env bash

command_exists () {
    type "$1" >/dev/null 2>&1 ;
}