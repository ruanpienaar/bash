#!/bin/bash
if [ -n "$1" ] && [ -n "$2" ]; then 
  find . -name "*.erl" -type f | xargs grep $1
else  
  usage
fi

function usage{
  echo "usage: ./find_str.sh [STR]"
}
