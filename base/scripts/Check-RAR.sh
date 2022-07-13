#!/bin/bash
# Requirements:
# • lscolors
# • rar (non-free)
# TODO: Make work w/ multiple files as input

if [[ "$#" -lt 1 ]]; then
	echo "Usage: Check-RAR.sh [FILE.RAR]"
	echo "Check RAR, return error code !=0 if an a problem"
	return 1
fi

fn="$1" # filename

# Check for new-style part01.rar-type names
if [[ $fn =~ part[0-9]*.rar ]]; then
	# echo parted file "$fn" detected
	# Skip everything not the first archive
	if [[ $fn == *part1.rar || $fn == *part01.rar || $fn == *part001.rar || $fn == *part0001.rar ]]; then
		# echo will check parted file "$fn"
		true
	else
		:
		# echo ignoring parted file "$fn"
		exit 0
	fi
fi

colored_fn=$(echo "$fn" | lscolors)
echo -n Checking "$colored_fn… "
base_dir=$(dirname "$fn")
# TODO: make sure base_dir exists
cd "$base_dir" || exit 1
# TODO: support unrar (free), libarchive, etc for testing
rar_output=$(rar t "$(basename "$fn")")
if [[ $rar_output == *"All OK"* ]]; then
	echo OK
	exit 0
else
	echo FAIL
	exit 1
fi
cd - || exit 1
