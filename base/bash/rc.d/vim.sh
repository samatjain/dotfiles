# Specify vimrc path
# On KDE, you must symlink this file into ~/.kde/env/. E.g.
# ln -s ~/.config/bash/rc.d/vim ~/.kde/env/vim.sh
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}" # Sometimes this isn't set…
export         VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export        GVIMINIT='let $MYGVIMRC="$XDG_CONFIG_HOME/vim/gvimrc" | source $MYGVIMRC'
export       VIMDOTDIR="$XDG_CONFIG_HOME/vim"
