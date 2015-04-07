#!/bin/bash

#function usage {                                                                                        │        at fitnesse.responders.ChunkingResponder$RespondingRunnable.run(ChunkingResponder.java:106)
#  echo "usage: ./find_str.sh [PATH] [Searching string]"                                                                     │        at java.lang.Thread.run(Thread.java:722)
#} 

if [ -n "$1" ] && [ -n "$2" ]; then
  echo "Looking for \"$2\" in $1"
  find $1 -name "*.erl" -type f | xargs grep $2 --color=always
else  
#  usage
   echo "mmm"
fi
