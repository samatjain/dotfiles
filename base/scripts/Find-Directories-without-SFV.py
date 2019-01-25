#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import pprint

if len(sys.argv) < 2:
    print '''Please provide a top-level path. Usage:
% find-directories-without-sfv.py .
   OR
% find-directories-without-sfv.py /somewhere'''
    sys.exit(1)

rootPath = sys.argv[1]

for path in os.walk(rootPath):
    dirName = path[0]
    dirContents = path[2]

    hasSFV = False

    for item in dirContents:
        if 'sfv' in item:
            hasSFV = True

    if not hasSFV:
        print dirName
