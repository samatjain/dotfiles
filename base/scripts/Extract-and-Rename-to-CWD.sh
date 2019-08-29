#/bin/sh
DIR=$(basename $(pwd))
rar e $1
mv *mkv $DIR.nfo
mv *mkv $DIR.mkv
mv *avi $DIR.avi
mv *sub $DIR.sub
mv *idx $DIR.idx
mv *mp4 $DIR.mp4
