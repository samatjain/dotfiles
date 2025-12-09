#!/bin/bash

# Everything in this file is purposefully a function, as they are meant
# to be used interactively only.

function remote-shell-screen() {
	if [[ "$#" -lt 2 ]]; then
		echo "Usage: remote-shell-screen [ssh|mosh] [HOST]"
		echo "Use specified remote shell (ssh or mosh) to HOST, attach to screen session running there"
		return 1
	fi
	local _shell=$1
	# TODO: verify that _shell is mosh or ssh
	shift
	local _host=$1
	shift
	local _short_host=${_host%%.*}
	local _session="a"
	echo "Using 🐚 ${_shell} to connect to 📕 session \"${_session}\" on 🖥️ ${_host}"
	set-term-title "$_short_host"
	# TODO: do we want to pass additional arguments to screen here?
	if [[ "${_shell}" == "ssh" ]]; then
		# BUG: weird problem, 1st invocation exits immediately, but 2nd invocation
		# sometimes works
		echo ssh -t "$_host" -- bash -ilc "screen -S ${_session} -D -R"
		ssh -t "$_host" -- bash -ilc \"screen -S ${_session} -D -R\"
	elif [[ "${_shell}" == "mosh" ]]; then
		echo mosh "$_host" -- bash -ilc "screen -S ${_session} -D -R"
		mosh "$_host" -- bash -ilc "screen -S ${_session} -D -R"
	else
		echo "ERROR: Unsupported shell specified"
		return 1
	fi
}

function mosh-screen() {
	if [[ "$#" -lt 1 ]]; then
		echo "Usage: mosh-screen [HOST]"
		echo "mosh to HOST, attach to screen session running there"
		return 1
	fi
	remote-shell-screen mosh "$@"
}
alias m=mosh-screen

function ssh-screen() {
	if [[ "$#" -lt 1 ]]; then
		echo "Usage: ssh-screen [HOST]"
		echo "ssh to HOST, attach to screen session running there"
		return 1
	fi
	remote-shell-screen ssh "$@"
}
alias s=ssh-screen

function mosh-jump() {
	if [[ "$#" -lt 2 ]]; then
		echo "Usage: mosh-jump [JUMP_HOST] [TARGET_HOST] [ARGS]..."
		echo "mosh to JUMP_HOST, ssh to TARGET_HOST, w/ further SSH arguments ARGS."
		return 1
	fi
	# First parameter is the jump host
	local _jump_host=$1
	shift
	local _host=$1
	shift
	local _short_host=${_host%%.*}
	echo "Connecting to 🖥️ ${_host} by way of 🖥️ ${_jump_host}"
	set-term-title "$_short_host"
	# Remaining parameters (incl. target host) are passed to mosh
	echo mosh "$_jump_host" -- ssh -t "$_host" -- "$@"
	mosh "$_jump_host" -- ssh -t "$_host" -- "$@"
}

function mosh-jump-screen() {
	if [[ "$#" -lt 2 ]]; then
		echo "Usage: mosh-jump-screen [JUMP_HOST] [TARGET_HOST]"
		echo "mosh to JUMP_HOST, ssh to TARGET_HOST, w/ attach to screen session there"
		return 1
	fi
	local _jump_host=$1
	shift
	local _host=$1
	shift
	local _short_host=${_host%%.*}
	local _session="a"
	# TODO: do we want to pass additional arguments to screen here?
	mosh-jump "$_jump_host" "$_host" bash -ilc \"screen -S "${_session}" -D -R\"
}
alias mj=mosh-jump-screen
