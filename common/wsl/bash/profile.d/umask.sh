# When running bash via WSL (Windows Subsystem for Linux, née Bash on
#  Windows), make sure umask is set to something sane
# Workaround for https://github.com/Microsoft/WSL/issues/352
if grep -q Microsoft /proc/version; then
    if [[ "$(umask)" == '0000' ]]; then
        umask 0022
    fi
fi
