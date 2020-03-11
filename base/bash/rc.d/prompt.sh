

# TODO: make simple-prompt function work again

# Based off of https://wiki.archlinux.org/index.php/Color_Bash_Prompt
function set_prompt() {
	Last_Command=$? # Must come first!
	Blue='\[\e[01;34m\]'
	White='\[\e[00;37m\]'
	BoldWhite='\[\e[01;37m\]'
	BoldRed='\[\e[01;31m\]'
	Red='\[\e[00;31m\]'
	BoldGreen='\[\e[01;32m\]'
	Green='\[\e[00;32m\]'
	Reset='\[\e[00m\]'
	FancyX='\342\234\227'
	Checkmark='\342\234\223'
	DarkGrey='\[\e[0;1;30m\]'

	# Set shell title if we're not in a Linux console
	if [ $TERM != "linux" ]; then
		PS1="\[\e]2;\u@\h:\w\a\\]"
	fi

	# if [ "`id -u`" = "0" ]; then
	if [[ $EUID == 0 ]]; then
		PS1+="$BoldRed\u@$BoldGreen\h$Red:\w\n"
	else
		PS1+="$BoldRed\u"
		PS1+="$BoldWhite@"
		PS1+="$BoldGreen\h"
		PS1+="$BoldWhite:"
		PS1+="$White\w\n"
	fi

	PS1+="$DarkGrey\t "

	# If it was successful, print a green check mark. Otherwise, print
	# a red X.
	if [[ $Last_Command == 0 ]]; then
		PS1+="$Green$Checkmark "
	else
		PS1+="$Red$FancyX "
	fi

	if [[ $EUID == 0 ]]; then
		PS1+="$BoldRed#$Reset "
	else
		PS1+="$BoldWhite\$$Reset "
	fi
}

# This, along with shopt -s histappend, stores history from all shells into
#  a single file
export PROMPT_COMMAND="set_prompt; history -a"

function simple-prompt () {
	export PROMPT_COMMAND="history -a"
	export PS1='[\t \u@\h \W]$ '
}
