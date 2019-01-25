#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import itertools
import sys

from pprint import pprint

f1_name = sys.argv[1]
f2_name = sys.argv[2]

def process_file(filename):
    file_iterator = open(filename)
    try:
        for line in file_iterator:
            line = line.split()
            crc = line[0].strip()
            filename = line[1].strip()
            yield crc, filename
    except:
        print('Improperly formed files in input', file=sys.stderr)
        sys.exit(1)

for f1, f2 in itertools.zip_longest(process_file(f1_name), process_file(f2_name)):
    if f1 is None or f2 is None:
        print('Checksum files have differing number of entries', file=sys.stderr)
        sys.exit(1)
    if f1[0] != f2[0]:
        print('%s and %s do not match' % (f1[1], f2[1]), file=sys.stderr)
