#!/bin/sh
youtube-dl -o '%(title)s-%(id)s.%(ext)s' --restrict-filenames "$@"
