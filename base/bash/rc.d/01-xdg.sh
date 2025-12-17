# Sometimes, on some systems, these are not picked up by bash_profile…
# XDG directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export  XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export   XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export  XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
# non-standard
export    XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
