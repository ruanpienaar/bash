#!/bin/bash

echo "Arguments were..."
#Returns a single string (`$1, $2 ... $n'') comprising all of the positional parameters separated by the internal field separator character (defined by the IFS environment variable). 
echo "\$\* is $*"

#Returns a sequence of strings (`$1'', `$2'', ... `$n'') wherein each positional parameter remains separate from the others. 
echo "\$\@ is $@"

echo "first \$1 argument is $1"

echo "name of this script $0" 

echo "number of arguments weere $#"

