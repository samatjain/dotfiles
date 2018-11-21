#!/bin/sh
# Check if GNU parallel is installed
# TODO: Actually check if GNU parallel is installed, rather than a command
#   called `parallel`
! hash parallel 2> /dev/null
GNU_PARALLEL_PRESENT=$?
for i in $@; do
	i=$(basename $i)
	if [ $GNU_PARALLEL_PRESENT -eq 1 ]; then
		echo "find $i -type f -print0 | parallel -q0 -k sha1sum > $i.sha1"
	else
		echo "find $i -type f -exec sha1sum '{}' \; > $i.sha1"
	fi
done
