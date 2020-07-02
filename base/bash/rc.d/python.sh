#!/bin/bash
# zsh compatible

if hash py 2> /dev/null; then
	_PY_CMD=py
else
	if hash python3 2> /dev/null; then
		_PY_CMD=python3
	else
		_PY_CMD=python
	fi
fi

alias py="${_PY_CMD}"
alias py2="python2"
alias py3="python3"

if hash pypy3 2> /dev/null; then
	alias pypy=pypy3
fi

unset _PY_CMD
