#!/bin/bash

for DIR in $( ls -l | grep dr | awk '{ print $9 }' ); do
   echo " --- "
   echo " --- Entering DIR : $DIR"
   echo " --- "
   cd $DIR
   git pull
   cd ../
done