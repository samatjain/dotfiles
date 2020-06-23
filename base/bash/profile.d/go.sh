#!/bin/bash

# Don't overrwrite an already configured GOPATH
if hash go 2>/dev/null && [[ -z "${GOPATH+1}" ]]
then
	export GOPATH="$HOME/.local/lib/go"
	export GO111MODULE=on
	export PATH="$PATH:$GOPATH/bin"
fi
