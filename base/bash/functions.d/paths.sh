# Functions related to paths

# CWD's basename
# zsh compatible
cwdb() {
	basename $(pwd)
}

# CWD's parent
# zsh compatible
cwdp() {
	dirname $(pwd)
}
