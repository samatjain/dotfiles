#!/usr/bin/env python3

"""
Tells all SSH control sockets to exit.

If your computer's network changes (e.g. laptop changing Wi-Fi
networks), SSH master processes for connection multiplexing will linger
until they hit time-outs. An extremely annoying side-effect of this is
that you won't be able to SSH to hosts that have such a process running
until they hit that time-out.

This script will attempt to terminate these processes early; next time you
SSH to the host in question a master process will be started again.
"""

import os
import subprocess
from pathlib import Path

# NOTE: This should be ssh_config's ControlPath
SSH_MUX_PATH = Path("~/.cache/ssh/cs/").expanduser().absolute()


def stop_ssh_control_masters():
    """Stop ssh control master processes."""
    with os.scandir(SSH_MUX_PATH) as dir_items_it:
        for e in dir_items_it:
            cmd = f"ssh -S {e.path} -O exit true &"
            print(cmd)
            subprocess.run(cmd, shell=True)


if __name__ == "__main__":
    stop_ssh_control_masters()
