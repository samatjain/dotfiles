#!/bin/bash

export PATH="$HOME/.local/bin:$PATH"

# Set the systemd-style DBUS address
# export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus

# Set path to inputrc configuration
export INPUTRC="$XDG_CONFIG_HOME/bash/inputrc"

# Set the session ssh-agent socket path (If it's not set)
[[ -z "$SSH_AUTH_SOCK" ]] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent"

# Look for terminfo files under data
[[ -d "$XDG_DATA_HOME/terminfo" ]] && export TERMINFO="$XDG_DATA_HOME/terminfo"

# httpie
hash http 2>/dev/null && export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"

# GNU PGP configuration directory
hash gpg 2> /dev/null && export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

# Mercurial configuration file
hash hg 2> /dev/null && export HGRCPATH="$XDG_CONFIG_HOME/hg/config"

# GNU screen configuration file
hash screen 2> /dev/null && export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"

if hash aws 2>/dev/null
then
	export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
	export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
fi

if hash redis-cli 2>/dev/null
then
	export REDISCLI_HISTFILE="$XDG_DATA_HOME/rediscli_history"
fi

hash ansible 2>/dev/null && export     ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/config.ini"

hash docker  2>/dev/null && export      DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
hash wget    2>/dev/null && export             WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgrep.rc"

# Less history file location
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
