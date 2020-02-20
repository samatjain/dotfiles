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
    echo -e "    \033[1;30m""$(builtin pwd)""\033[0m"
}

# CWD's basename
# zsh compatible
bpwd() {
	if [[ -n "$1" ]]; then
		basename "$1"
	else
		basename "$(pwd)"
	fi
}

# CWD's parent
# zsh compatible
ppwd() {
	if [[ -n "$1" ]]; then
		dirname "$1"
	else
		dirname "$(pwd)"
	fi
}

cl() { cd "$1" || exit && ls; }
# Create and change into a directory
mdcd() { mkdir -p "$1"; cd "$1" || exit; }

# Print the full path to a file
fp() {
	if [[ -n "$1" ]]; then
		readlink -f "$1"
	else
		readlink -f .
	fi
}
#alias fp='readlink -f'
#function fp() {
#	echo `pwd`/$1
#}

# Print the full path to a file, including hostname
fpr() {
	echo "$(hostname):$(fp "$@")"
}

# Print the full path to a file, including hostname.local for use on LANs
fpl() {
	echo "$(hostname).local:$(fp "$@")"
}
