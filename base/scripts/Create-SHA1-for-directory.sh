#!/bin/sh
for i in $@; do
	i=$(basename $i)
	echo "find $i -type f -exec sha1sum '{}' \; > $i.sha1"
done
