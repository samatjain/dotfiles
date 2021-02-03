# Configuration file for pip
hash pip 2> /dev/null && export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"
hash pip3 2> /dev/null && export PIP_CONFIG_FILE="$XDG_CONFIG_HOME/pip/pip.conf"

if hash python 2>/dev/null
then
  # Disable python bytecode generation
  #export PYTHONDONTWRITEBYTECODE=1

  # Pyenv should follow XDG
  export PYENV_ROOT="$XDG_DATA_HOME/pyenv"

  # Configure poetry
  export POETRY_HOME="$HOME/.local/lib/poetry"
  export PATH="$PATH:$POETRY_HOME/bin"
fi
