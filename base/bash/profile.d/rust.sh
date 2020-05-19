#!/bin/bash
# Source default install directory for rustup.rs and cargo
[[ -f "${HOME}/.cargo/env" ]] && source "${HOME}/.cargo/env"
# Debian-installed cargo doesn't create the above env file, so manually add to path
[[ ! -f "${HOME}/.cargo/env" ]] && [[ -d "${HOME}/.cargo/bin" ]] && export PATH="${HOME}/.cargo/bin:${PATH}"
