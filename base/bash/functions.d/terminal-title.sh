#!/bin/bash

if [ -n "$KONSOLE_DBUS_SESSION" ]; then
    # From: https://stackoverflow.com/posts/54142398/revisions
    set-konsole-tab-title-type() {
        # Usage: set-konsole-tab-title-type ${TITLE} ${TYPE}, where TYPE is:
        # • 0: local
        # • 1: remote

        local _title=$1
        local _type=${2:-0}
        [[ -z "${_title}" ]]               && return 1
        [[ -z "${KONSOLE_DBUS_SERVICE}" ]] && return 1
        [[ -z "${KONSOLE_DBUS_SESSION}" ]] && return 1
        qdbus >/dev/null "${KONSOLE_DBUS_SERVICE}" "${KONSOLE_DBUS_SESSION}" setTabTitleFormat "${_type}" "${_title}"
    }
    set-konsole-tab-title() {
        set-konsole-tab-title-type $1   && \
        set-konsole-tab-title-type $1 1
    }
fi

set-term-title() {
    # Set terminal title. Usage: set-term-title ${TITLE}
    #
    # If we're in a screen, only set the title there. If we're running screen
    # in Konsole, it will /not/ be set.
    # If we're in a regular terminal or Konsole, set the title and in the
    # current Konsole tab, if applicable.
    local _title=$1
    if [ -n "$STY" ]; then  # Inside a screen session
        echo -ne "\033k${_title}\033\\"
    else  # Regular terminal
        echo -ne "\033]30;${_title}\007"
        # Based on: https://stackoverflow.com/posts/54142398/revisions
        if [ -n "$KONSOLE_DBUS_SESSION" ]; then  # Konsole
            set-konsole-tab-title "${_title}"  # Use title we just set
        fi
    fi
}
