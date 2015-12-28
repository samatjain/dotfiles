#!/usr/bin/env python
import sys

def processMD5Line(line):
    md5 = line[0:32]
    fileName = line[34:]

    return md5, fileName

if len(sys.argv) < 2:
    print "Insufficient number of arguments"
    sys.exit(1)

existingFiles = {}

originalFile = file(sys.argv[1])
targetFile = file(sys.argv[2])

for line in originalFile:
    line = line.rstrip()
    (md5, fileName) = processMD5Line(line)
    existingFiles[md5] = fileName

for line in targetFile:
    line = line.rstrip()
    (md5, fileName)= processMD5Line(line)

    if existingFiles.has_key(md5):
        print "mv \"%s\" \"%s\"" % \
            (existingFiles[md5], fileName)

originalFile.close()
targetFile.close()


