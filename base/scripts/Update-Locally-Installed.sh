#!/usr/bin/bash
# { cargo install --git https://github.com/astral-sh/rye rye --force; } &
{ pipx upgrade-all --include-injected --verbose; } &
{ cargo install-update --all; } &
{ uv tool upgrade --all; } &
wait
