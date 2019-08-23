# Functions related to paths

# CWD's basename
# zsh compatible
bpwd() {
	basename $(pwd)
}

# CWD's parent
# zsh compatible
ppwd() {
	dirname $(pwd)
}
