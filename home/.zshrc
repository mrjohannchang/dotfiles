# Powerlevel10k 1/2 {
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# } Powerlevel10k 1/2


# compinstall {
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/johann/.zshrc'

autoload -Uz compinit && compinit
# End of lines added by compinstall
# } compinstall


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

## disable ctrl-d
setopt IGNORE_EOF

## HIST_IGNORE_ALL_DUPS: If a new command line being added to the history list
## duplicates an older one, the older command is removed from the list (even if
## it is not the previous event).
setopt HIST_IGNORE_ALL_DUPS

## Activate the bash-style comments in interactive mode
setopt INTERACTIVE_COMMENTS

bindkey "^T" history-incremental-search-forward

## locale
[[ -n "$LANG" ]] || export LANG=en_US.UTF-8
[[ -n "$LC_ALL" ]] || export LC_ALL=en_US.UTF-8
# } General


# Dart {
## Dart completions
if [ -f "${HOME}/.dart-cli-completion/zsh-config.zsh" ]; then
  source "${HOME}/.dart-cli-completion/zsh-config.zsh"
fi
# } Dart


# fd-find {
if command -v fdfind &>/dev/null; then
  alias fd=fdfind
fi

case "${OSTYPE:l}" in
  cygwin*|msys*)
    alias fd='fd --path-separator="//"'
    ;;
esac
# } fd-find


# less {
export LESS="$LESS --ignore-case --no-init --quit-if-one-screen --RAW-CONTROL-CHARS"
# } less


# ls
## enable the color support of ls
if command -v dircolors &>/dev/null; then
  if [ -r "${HOME}/.dircolors" ]; then
    eval "$(dircolors -b "${HOME}/.dircolors" 2>/dev/null)" || eval "$(dircolors -b)"
    alias ls="ls --quoting-style=literal --color=auto"
  fi
fi
# } ls


# Neovide {
alias neovide="neovide --multigrid"
# } Neovide


# ripgrep {
case "${OSTYPE:l}" in
  cygwin*|msys*)
    alias rg='rg --path-separator="//"'
    ;;
esac
# } ripgrep


# SSH {
## TODO: Move SSH agent out as a standalone plugin
## Refresh SSH agent in case it was dead
if [ ! -z "$SSH_AUTH_SOCK" \
    -a "$SSH_AUTH_SOCK" != "${HOME}/.ssh/agent_sock" ] ; then
  unlink "${HOME}/.ssh/agent_sock" 2>/dev/null
  ln -s "$SSH_AUTH_SOCK" "${HOME}/.ssh/agent_sock"
  export SSH_AUTH_SOCK="${HOME}/.ssh/agent_sock"
fi
# } SSH


# ================================= plugins =================================
# ZI https://github.com/z-shell/zi {
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
zi snippet OMZ::plugins/docker/docker.plugin.zsh
zi snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh
zi snippet OMZ::plugins/nvm/nvm.plugin.zsh
zi snippet OMZ::plugins/pyenv/pyenv.plugin.zsh
zi snippet OMZ::plugins/rvm/rvm.plugin.zsh

zi ice wait lucid atload'_zsh_autosuggest_start'
zi light zsh-users/zsh-autosuggestions

zi ice blockf
zi light zsh-users/zsh-completions
# } ZI
# ================================= plugins =================================


# gh {
if command -v gh &>/dev/null; then
  eval "$(gh completion -s zsh)"
fi
# }


# zoxide {
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi
# } zoxide


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
# } Workaround


# .zshrc.light (configs for light background terminals) {
if [ -r "${HOME}/.zshrc.light" ]; then
  source "${HOME}/.zshrc.light"
fi
# } .zshrc.light (configs for light background terminals)


# .zshrc.custom {
if [ -r "${HOME}/.zshrc.custom" ]; then
  source "${HOME}/.zshrc.custom"
fi
# } .zshrc.custom


# Powerlevel10k 2/2 {
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "${HOME}/.p10k.zsh" ]] || source "${HOME}/.p10k.zsh"
# Avoid large git repos slowing down prompts
# https://github.com/Powerlevel9k/powerlevel9k/issues/1105
POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=10000
# } Powerlevel10k 2/2
