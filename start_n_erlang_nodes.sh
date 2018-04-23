#!/bin/bash
set -x
if [ $# -lt 1 ]; then
    echo "Usage: ./start_n_erlang_nodes.sh NodeCount"
    exit 0
fi
for N in `seq 1 $1`; do
    erl -sname "testnode$N@localhost" -setcookie cookie -detached -noinput -noshell
done
