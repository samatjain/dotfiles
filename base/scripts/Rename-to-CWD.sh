#!/bin/sh +x
ORIGINAL_FILE=$1
EXTENSION=$(echo "$@" | pyline "line.split('.')[-1]")
mv $ORIGINAL_FILE $(basename $(pwd)).$EXTENSION
