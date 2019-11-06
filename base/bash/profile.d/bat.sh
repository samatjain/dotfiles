#!/bin/bash

# Much of this is inspired from:
#   https://github.com/eth-p/bat-extras/blob/master/src/batman.sh

if hash bat 2> /dev/null; then
	export PAGER=bat

	# Use bat for man
	export MANPAGER='sh -c "col -bx | '"$(printf "%q" bat)"' --language man --style plain"'
	export MANROFFOPT='-c'

	alias batp="bat --style plain"
else
	alias bat="cat"
	alias batp="cat"
fi
