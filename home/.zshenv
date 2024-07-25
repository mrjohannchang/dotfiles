# Executable {
## Go {
if [ -d "${HOME}/go/bin" ]; then
  export PATH="${HOME}/go/bin:${PATH}"
fi
## } Go

## PlatformIO {
if [ -d "${HOME}/.platformio/penv/bin" ]; then
  export PATH="${HOME}/.platformio/penv/bin:${PATH}"
fi
## } PlatformIO

## Python {
### User executables
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

### Poetry
if [ -d "${HOME}/.poetry/bin" ]; then
  export PATH="${HOME}/.poetry/bin:${PATH}"
fi
## } Python

## Rust {
if [ -f "${HOME}/.cargo/env" ]; then
  source "${HOME}/.cargo/env"
fi
## } Rust

## Snappy {
if [ -d "/snap/bin" ]; then
  export PATH="/snap/bin:${PATH}"
fi
## } Snappy

## Local {
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
## } Local
# } Executable


# Editor {
## Neovim
## VISUAL vs. EDITOR – what’s the difference?
## https://unix.stackexchange.com/questions/4859/visual-vs-editor-what-s-the-difference
if command -v nvim &>/dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
fi
# } Editor
