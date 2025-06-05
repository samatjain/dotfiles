#!/bin/bash
# zsh compatible

# from Debian's fdfind package
if hash fdfind 2> /dev/null; then
	_FD_CMD=fdfind
elif hash fd 2> /dev/null; then
	_FD_CMD=fd
fi

if [[ -n $_FD_CMD ]]; then
	alias fd=$_FD_CMD
	alias fdfind=$_FD_CMD
fi

# Pipe to this alias to output find/fd's output as a tree, e.g.
#
#     fd -e py | as-tree
#
# ref: https://github.com/sharkdp/fd#printing-the-output-as-a-tree
alias as-tree="tree --fromfile"

unset _FD_CMD
