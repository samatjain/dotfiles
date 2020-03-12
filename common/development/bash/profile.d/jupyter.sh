# Configuration file for jupyter
if hash jupyter 2>/dev/null
then
	export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter/"
fi
