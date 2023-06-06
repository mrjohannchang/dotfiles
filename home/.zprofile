# Homebrew {
if [ command -v /opt/homebrew/bin/brew &> /dev/null ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
# }


# pyenv {
if [ -d "${HOME}/.pyenv" ]; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:$PATH"
  eval "$(pyenv init --path)"
fi
# }
