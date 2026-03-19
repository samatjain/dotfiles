#!/bin/bash
# Requirements:
# • lscolors
# • rar (non-free)
# TODO: Make work w/ multiple files as input

if [[ "$#" -lt 1 ]]; then
	echo "Usage: Check-ZIP.sh [FILE.RAR]"
	echo "Check ZIP, return error code !=0 if an a problem"
	return 1
fi

fn="$1" # filename

colored_fn=$(echo "$fn" | lscolors)
echo -n Checking "$colored_fn… "
base_dir=$(dirname "$fn")
# TODO: make sure base_dir exists
cd "$base_dir" || exit 1
# TODO: support unrar (free), libarchive, etc for testing
cmd_output=$(unzip -t "$(basename "$fn")")
if [[ $cmd_output == *"No errors detected in compressed data"* ]]; then
	echo OK
	exit 0
else
	echo FAIL
	exit 1
fi
cd - || exit 1
