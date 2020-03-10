#!/bin/bash

set -eEuo pipefail  # unofficial bash "strict" mode
#set -o xtrace       # for debugging

__dir="$(builtin cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# shellcheck source=init-dots
source "${__dir}/init-dots"
dots groups set base
dots install
