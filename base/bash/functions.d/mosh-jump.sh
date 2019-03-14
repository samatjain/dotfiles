#!/bin/bash
function mosh-jump() {
    # Purposefully a function, as this should only be used interactively.
    if [ "$#" -lt 2 ]; then
        echo "Usage: mosh-jump [JUMP_HOST] [TARGET_HOST] [ARGS]..."
        echo "mosh to JUMP_HOST, ssh to TARGET_HOST, w/ further SSH arguments ARGS."
        return 1
    fi
    # First parameter is the jump host
    _jump_host=$1
    shift
    # Remaining parameters (incl. target host) are passed to mosh
    mosh $_jump_host -- ssh -t $@
}
