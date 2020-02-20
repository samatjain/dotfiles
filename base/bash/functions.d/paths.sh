# Functions related to paths

# Print working directory after cd
# zsh compatible
# From: https://node.mu/2010/11/24/is-your-bash-prompt-cramping-your-style/
cd() {
    if [[ $@ == '-' ]]; then
        builtin cd "$@" > /dev/null  # We'll handle pwd.
    else
        builtin cd "$@"
    fi
    echo -e "    \033[1;30m"`builtin pwd`"\033[0m"
}

# CWD's basename
# zsh compatible
bpwd() {
	if [[ -n "$1" ]]; then
		basename "$1"
	else
		basename $(pwd)
	fi
}

# CWD's parent
# zsh compatible
ppwd() {
	if [[ -n "$1" ]]; then
		dirname "$1"
	else
		dirname $(pwd)
	fi
}
