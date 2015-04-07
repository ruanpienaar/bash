#!/bin/bash

function usage {
  echo "find_str.sh [PATH] [FILENAME]"
}

if [ -n "$1" ] && [ -n "$2" ]; then
  echo "Looking for \"$2\" in $1"
  find $1 -name "*.erl" -type f | xargs grep $2 --color=always
else  
  usage
fi
