#!/bin/sh
basename=$(basename $1 .)

files=$(find . -name "*$basename*" | grep -v sfv | grep -v nfo | grep -v txt | grep -v md5 | grep -v sha1 | sort)

rm -rf *.sfv *.md5 *.sha1

for f in $files; do
	f=$(basename $f)
	echo Processing $f...
	#cksfv $f | tail -n 2 >> $basename.sfv.unsorted
	cfv -t sfv -C -VV -f - $f | tail -n 1 >> $basename.sfv.unsorted
	md5sum $f >> $basename.md5.unsorted
	sha1sum $f >> $basename.sha1.unsorted
done
## What is this doing here?
#cat $basename.sfv > /dev/null
cat $basename.sfv.unsorted | sort > $basename.sfv
mv $basename.md5.unsorted $basename.md5
mv $basename.sha1.unsorted $basename.sha1
rm $basename.sfv.unsorted
