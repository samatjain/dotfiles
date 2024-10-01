#!/bin/bash
# zsh compatible

# Much of this is inspired from:
#   https://github.com/eth-p/bat-extras/blob/master/src/batman.sh

# from Debian's bat package
if hash batcat 2> /dev/null; then
	_BAT_CMD=batcat
fi
if hash bat 2> /dev/null; then
	_BAT_CMD=bat
fi

if [[ -n $_BAT_CMD ]]; then
	export PAGER="$_BAT_CMD"
	export BAT_PAGER="less -RF"

	# Use bat for man
	export MANPAGER='sh -c "col -bx | '"$(printf "%q" $_BAT_CMD)"' --language man --style plain"'
	export MANROFFOPT='-c'

	alias bat=$_BAT_CMD
	alias batcat=$_BAT_CMD
	alias batp="$_BAT_CMD --style plain --wrap=never"  # deprecated alias for pp
	alias pp="$_BAT_CMD --style plain --wrap=never"  # "plain" pager, no line numbers
	alias pf="$_BAT_CMD --style full --wrap=never"  # all bat features enabled
else
	alias bat="cat"
	alias batcat="cat"
	alias batp="cat"
	alias p="cat"
	alias pp="cat"
	alias pf="cat"
fi

unset _BAT_CMD
