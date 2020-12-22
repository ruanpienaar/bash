#!/bin/bash

## !!! Relies on the bash built in getopts !!!

while getopts "c:t:" OPTION; do
    case $OPTION in
    c)
    	echo "cmd was given"
        COMMAND_TO_RUN=$OPTARG
        ;;
    t)
        echo "times was given"
        TIMES=$OPTARG
        ;;
    *)
        echo "Incorrect options provided"
        exit 1
        ;;
    esac
done


echo "CMD:   ["$COMMAND_TO_RUN"]"
echo "TIMES: ["$TIMES"]"

if [ -z "$COMMAND_TO_RUN" ]; then
    echo "Cmd is missing"
    exit 1
fi
if [ -z "$TIMES" ]; then
    TIMES=indefinite
fi

echo "Running $COMMAND_TO_RUN $TIMES Times ... Press ^C to quit..."

#exit 123

RET=0
while [ "$RET" == 0 ]; do
    echo "Running $TIMES times ..."
    if [ "$TIMES" == "indefinite" ]; then
        $COMMAND_TO_RUN
    elif [ $TIMES -eq 0 ]; then
        exit 0
    elif [ $TIMES -lt 0 ]; then
        exit 0
    elif [ $TIMES -gt 0 ]; then
        $COMMAND_TO_RUN
        TIMES=$((TIMES-1))
    fi
    RET=$?
done