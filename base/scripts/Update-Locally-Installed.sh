#!/usr/bin/bash
{ pipx upgrade-all --include-injected --verbose; } &
{ cargo install-update --all; } &
{ uv tool upgrade --all; } &
{ npm update -g; } &
wait
