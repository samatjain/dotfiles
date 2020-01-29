#!/bin/sh
# Check if GNU parallel is installed
# TODO: Actually check if GNU parallel is installed, rather than a command
#   called `parallel`
! hash parallel 2> /dev/null
_GNU_PARALLEL_PRESENT=$?
# Check if xxhsum is installed
! hash xxhsum 2> /dev/null
_XXH_PRESENT=$?
for i in $@; do
	i=$(basename $i)
	dst=$i
	# If path argument is ".", then use CWD instead
	if [ $i = "." ]; then
		dst=$(basename $(pwd))
		echo "# WARNING: Remove this file"
	fi
	if [ $_GNU_PARALLEL_PRESENT -eq 1 ]; then
		echo "find \"$i\" -type f ! -name \"$dst.sha1\" ! -name \"$dst.xxh\" -print0 | parallel -q0 -k sha1sum > \"$dst.sha1\""
		if [ $_XXH_PRESENT -eq 1 ]; then
			echo "find \"$i\" -type f ! -name \"$dst.sha1\" ! -name \"$dst.xxh\" -print0 | parallel -q0 -k xxhsum -q > \"$dst.xxh\""
		fi
	else
		echo "find \"$i\" -type f ! -name \"$dst.sha1\" ! -name \"$dst.xxh\" -exec sha1sum '{}' \; > \"$dst.sha1\""
		if [ $_XXH_PRESENT -eq 1 ]; then
			# If we don't have GNU parallel, assume we're using an old xxhsum w/o -q too
			echo "find \"$i\" -type f ! -name \"$dst.sha1\" ! -name \"$dst.xxh\" -exec xxhsum -q '{}' \; > \"$dst.xxh\""
		fi
	fi
done
