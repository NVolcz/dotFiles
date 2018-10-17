#!/usr/bin/env bash
if [ $# -eq 0 ]
then
     echo "Usage: $0 program arg1 arg2 ..."
     exit 1
fi
prog="$1"
shift
exec cygstart --action=runas `which "$prog"` "$@"