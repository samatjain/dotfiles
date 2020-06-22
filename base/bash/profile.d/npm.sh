# Configuration file for nodejs' npm
if hash node 2>/dev/null
then
	export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
fi

if hash npm 2>/dev/null
then
	export PATH="${HOME}/.local/lib/nodejs/bin:${PATH}"
	export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
	export NPM_CONFIG_DEVDIR="$XDG_CACHE_HOME/node-gyp"
fi
