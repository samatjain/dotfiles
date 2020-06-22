# Configuration file for pip
hash pip 2> /dev/null && export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
hash pip3 2> /dev/null && export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
