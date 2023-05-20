# Powerlevel10k 1/2 {
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }


# General {
export CASE_SENSITIVE=true
case "${OSTYPE:l}" in
  cygwin*|msys*)
    export CASE_SENSITIVE=false
    ;;

  darwin*)
    # ls color
    if command -v gdircolors &>/dev/null; then
      if [ -r "${HOME}/.dircolors" ]; then
        eval "$(gdircolors -b "${HOME}/.dircolors" 2>/dev/null)" || eval "$(gdircolors -b)"
        alias ls="gls --quoting-style=literal --color=auto"
      fi
    fi

    # updatedb
    alias updatedb="sudo /usr/libexec/locate.updatedb"
    ;;
esac

# disable ctrl-d
setopt IGNORE_EOF

# HIST_IGNORE_ALL_DUPS: If a new command line being added to the history list
# duplicates an older one, the older command is removed from the list (even if
# it is not the previous event).
setopt HIST_IGNORE_ALL_DUPS

# Snappy binary dir
if [ -d "/snap/bin" ]; then
  export PATH="/snap/bin:${PATH}"
fi

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

# Activate the bash-style comments in interactive mode
setopt INTERACTIVE_COMMENTS

bindkey "^T" history-incremental-search-forward

# locale
[[ -n "$LANG" ]] || export LANG=en_US.UTF-8
[[ -n "$LC_ALL" ]] || export LC_ALL=en_US.UTF-8

# Neovim
# VISUAL vs. EDITOR – what’s the difference?
# https://unix.stackexchange.com/questions/4859/visual-vs-editor-what-s-the-difference
if command -v nvim &>/dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
fi
# }


# enable the color support of ls {
if command -v dircolors &>/dev/null; then
  if [ -r "${HOME}/.dircolors" ]; then
    eval "$(dircolors -b "${HOME}/.dircolors" 2>/dev/null)" || eval "$(dircolors -b)"
    alias ls="ls --quoting-style=literal --color=auto"
  fi
fi
# }


# ZI {
if [[ ! -f ${HOME}/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://z.digitalclouds.dev/ecosystem/annexes
zicompinit # <- https://z.digitalclouds.dev/docs/guides/commands

zi ice depth"1"
zi light romkatv/powerlevel10k

zi snippet OMZ::lib/clipboard.zsh
zi snippet OMZ::lib/completion.zsh
zi snippet OMZ::lib/functions.zsh
zi snippet OMZ::lib/history.zsh
zi snippet OMZ::lib/key-bindings.zsh
zi snippet OMZ::lib/misc.zsh
zi snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zi snippet OMZ::plugins/nvm/nvm.plugin.zsh
zi snippet OMZ::plugins/pyenv/pyenv.plugin.zsh
zi snippet OMZ::plugins/rvm/rvm.plugin.zsh

zi ice wait lucid atload'_zsh_autosuggest_start'
zi light zsh-users/zsh-autosuggestions

zi ice blockf
zi light zsh-users/zsh-completions
# }


# fd-find {
if command -v fdfind &>/dev/null; then
  alias fd=fdfind
fi

case "${OSTYPE:l}" in
  cygwin*|msys*)
    alias fd='fd --path-separator="//"'
    ;;
esac
# }


# less {
export LESS="$LESS --ignore-case --no-init --quit-if-one-screen --RAW-CONTROL-CHARS"
# }


# PlatformIO {
if [ -d "${HOME}/.platformio/penv/bin" ]; then
  export PATH="${HOME}/.platformio/penv/bin:${PATH}"
fi
# }


# Python user executables {
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
    ;;
esac
# }


# Python Poetry executables {
if [ -d "${HOME}/.poetry/bin" ]; then
  export PATH="${HOME}/.poetry/bin:${PATH}"
fi
# }


# ripgrep {
case "${OSTYPE:l}" in
  cygwin*|msys*)
    alias rg='rg --path-separator="//"'
    ;;
esac
# }


# rvm {
if [ -s "${HOME}/.rvm/scripts/rvm" ]; then
  source "${HOME}/.rvm/scripts/rvm"
fi
# }


# TODO: Move SSH agent out as a standalone plugin
# Refresh SSH agent in case it was dead {
if [ ! -z "$SSH_AUTH_SOCK" \
    -a "$SSH_AUTH_SOCK" != "${HOME}/.ssh/agent_sock" ] ; then
  unlink "${HOME}/.ssh/agent_sock" 2>/dev/null
  ln -s "$SSH_AUTH_SOCK" "${HOME}/.ssh/agent_sock"
  export SSH_AUTH_SOCK="${HOME}/.ssh/agent_sock"
fi
# }


# zoxide {
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi
# }


# Workaround {
case "${OSTYPE:l}" in
  cygwin*|msys*)
    # Fix empty tmp env that causes CMake compiling failed on Windows
    [ -n "$tmp" ] || {
      unset tmp
    }
    [ -n "$temp" ] || {
      unset temp
    }
    [ -n "$TMP" ] || {
      unset TMP
    }
    [ -n "$TEMP" ] || {
      unset TEMP
    }
    if [ -n "$tmp" -a -n "TMP" ]; then
      unset tmp
    fi
    if [ -n "$temp" -a -n "TEMP" ]; then
      unset temp
    fi

    # Fix Home End key settings that stop them from acting as expected on Windows Terminal
    # Source: https://superuser.com/a/589629/270174
    # Related:
    #   https://stackoverflow.com/q/8638012
    #   https://stackoverflow.com/q/12382499
    #   https://stackoverflow.com/q/161676
    bindkey "^[[1~" beginning-of-line
    bindkey "^[[4~" end-of-line
    ;;
esac
# }


# Powerlevel10k 2/2 {
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Avoid large git repos slowing down prompts
# https://github.com/Powerlevel9k/powerlevel9k/issues/1105
POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=10000
# }


# Neovide {
alias neovide="neovide --multigrid"
# }


# .zshrc.light (configs for light background terminals) {
if [ -r "${HOME}/.zshrc.light" ]; then
  source "${HOME}/.zshrc.light"
fi
# }
