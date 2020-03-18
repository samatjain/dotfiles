#!/bin/bash
# zsh compatible

# Much of this is inspired from:
#   https://github.com/eth-p/bat-extras/blob/master/src/batman.sh

# from Debian's bat package
if hash batcat 2> /dev/null; then
	_BAT_CMD=batcat
elif hash bat 2> /dev/null; then
	_BAT_CMD=bat
fi

if [[ -n $_BAT_CMD ]]; then
	export PAGER=$_BAT_CMD

	# Use bat for man
	export MANPAGER='sh -c "col -bx | '"$(printf "%q" $_BAT_CMD)"' --language man --style plain"'
	export MANROFFOPT='-c'

	alias bat=$_BAT_CMD
	alias batcat=$_BAT_CMD
	alias batp="$_BAT_CMD --style plain --wrap=never"
else
	alias bat="cat"
	alias batcat="cat"
	alias batp="cat"
fi

unset _BAT_CMD
