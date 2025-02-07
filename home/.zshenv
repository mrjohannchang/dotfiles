# General {
## Editor
## Neovim
## VISUAL vs. EDITOR – what’s the difference?
## https://unix.stackexchange.com/questions/4859/visual-vs-editor-what-s-the-difference
if command -v nvim &>/dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
fi
##

## $HOME bin.d
PATH="${HOME}/bin:${PATH}"
[ ! -d "${HOME}/bin.d" ] || {
  for d in "${HOME}/bin.d/"*; do
    if [ ! -d "$d" ] && [ ! -L "$d" -a -d "$d" ]; then
      continue
    fi
    PATH="${d}:${PATH}"
  done
}
PATH="${HOME}/.local/bin:${PATH}"
# } General


# Homebrew {
# Homebrew is dependent on the shell, so it should be loaded before other paths.
if command -v /opt/homebrew/bin/brew &> /dev/null; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
# } Homebrew


# Android SDK {
if [ -d "${HOME}/Android/Sdk" ]; then
  export ANDROID_HOME="${HOME}/Android/Sdk"
elif [ -d "${HOME}/Library/Android/sdk" ]; then
  export ANDROID_HOME="${HOME}/Library/Android/sdk"
fi
if [ -n "$ANDROID_HOME" ]; then
  export PATH="${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}"
fi
# } Android SDK


# Go {
if [ -d "${HOME}/go/bin" ]; then
  export PATH="${HOME}/go/bin:${PATH}"
fi
# } Go


# Python {
## User executables
case "${OSTYPE:l}" in
  cygwin*|msys*)
    if [ -d "${HOME}/AppData/Roaming/Python" ]; then
      for d in "${HOME}/AppData/Roaming/Python/"*"/Scripts"; do
        export PATH="${d}:${PATH}"
      done
    fi
    ;;
  darwin*)
    if [ -d "${HOME}/Library/Python" ]; then
      for d in "${HOME}/Library/Python/"*"/bin"; do
        export PATH="${d}:${PATH}"
      done
    fi
    if [ -d "/Library/Frameworks/Python.framework/Versions/Current/bin" ]; then
        export PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
    fi
    ;;
esac

## Poetry
if [ -d "${HOME}/.poetry/bin" ]; then
  export PATH="${HOME}/.poetry/bin:${PATH}"
fi

## pyenv
if [ -d "${HOME}/.pyenv" ]; then
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  eval "$(pyenv init - zsh)"
fi
# } Python


# Ruby {
## Gem
if [ -d "${HOME}/.gem/bin" ]; then
  export PATH="${HOME}/.gem/bin:${PATH}"
fi

## RVM
if [ -s "${HOME}/.rvm/scripts/rvm" ]; then
  source "${HOME}/.rvm/scripts/rvm"
fi
# } Ruby


# Rust {
if [ -f "${HOME}/.cargo/env" ]; then
  source "${HOME}/.cargo/env"
fi
# } Rust


# Snappy {
if [ -d "/snap/bin" ]; then
  export PATH="/snap/bin:${PATH}"
fi
# } Snappy


# .zshenv.custom {
if [ -r "${HOME}/.zshenv.custom" ]; then
  source "${HOME}/.zshenv.custom"
fi
# } .zshenv.custom
