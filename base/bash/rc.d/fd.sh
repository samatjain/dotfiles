#!/bin/bash

# from Debian's fdfind package
if hash fdfind 2> /dev/null; then
	_FD_CMD=fdfind
elif hash fd 2> /dev/null; then
	_FD_CMD=fd
fi

if [ -n $_FD_CMD ]; then
	alias fd=$_FD_CMD
	alias fdfind=$_FD_CMD
fi
