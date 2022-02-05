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


# Znap {
# TODO: Remove the dependency on hard-coded path to ${HOME}/dotfiles
if [ -r "${HOME}/dotfiles/3rdparties/zsh-snap/znap.zsh" ]; then
  zstyle ':znap:*' repos-dir "${HOME}/dotfiles/3rdparties/zsh-snap-plugins"
  source "${HOME}/dotfiles/3rdparties/zsh-snap/znap.zsh"

  znap prompt romkatv/powerlevel10k

  znap source ohmyzsh/ohmyzsh \
    lib/{clipboard,completion,functions,history,key-bindings,misc} \
    plugins/{docker-compose,nvm,pyenv,rvm}
  znap source zsh-users/zsh-autosuggestions
  znap source zsh-users/zsh-completions
fi
# }


# fd-find {
if command -v fdfind &>/dev/null; then
  alias fd=fdfind
fi
# }


# less {
export LESS="$LESS --quit-if-one-screen --ignore-case --RAW-CONTROL-CHARS"
# }


# Python Poetry executables {
if [ -d "${HOME}/.poetry/bin" ]; then
  export PATH="${HOME}/.poetry/bin:${PATH}"
fi
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


# zsh-autosuggestions {
# Workaround for Random ←[?1h is showing
# https://github.com/zsh-users/zsh-autosuggestions/issues/614
unset ZSH_AUTOSUGGEST_USE_ASYNC
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
# }


# .zshrc.light (configs for light background terminals) {
if [ -r "${HOME}/.zshrc.light" ]; then
  source "${HOME}/.zshrc.light"
fi
# }
