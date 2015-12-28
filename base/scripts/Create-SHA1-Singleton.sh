#!/bin/sh
for i in $@; do
	i=$(basename $i)
	sha1sum $i > $i.sha1
done
