#!/bin/bash
find . -name '*.sha1' -execdir sha1sum -c '{}' \;
