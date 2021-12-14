# misc {
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
    if [ ! -d "$d" ] && [ ! -L "$d" && -d "$d" ]; then
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


# TODO: Move SSH agent out as a standalone plugin
# Refresh SSH agent in case it was dead {
if [ ! -z "$SSH_AUTH_SOCK" \
    -a "$SSH_AUTH_SOCK" != "${HOME}/.ssh/agent_sock" ] ; then
  unlink "${HOME}/.ssh/agent_sock" 2>/dev/null
  ln -s "$SSH_AUTH_SOCK" "${HOME}/.ssh/agent_sock"
  export SSH_AUTH_SOCK="${HOME}/.ssh/agent_sock"
fi
# }


# Znap {
if [ -r "${HOME}/dotfiles/3rdparty/zsh-snap/znap.zsh" ]; then
  zstyle ':znap:*' repos-dir "${HOME}/dotfiles/3rdparty/zsh-snap-plugins"
  source "${HOME}/dotfiles/3rdparty/zsh-snap/znap.zsh"

  znap prompt romkatv/powerlevel10k

  znap source changyuheng/fz
  znap source ohmyzsh/ohmyzsh \
    lib/{completion,history,key-bindings} \
    plugins/{docker-compose,nvm,pyenv,rvm}
  znap source rupa/z z.sh
  znap source zsh-users/zsh-autosuggestions
  znap source zsh-users/zsh-completions
  znap source zsh-users/zsh-syntax-highlighting
fi
# }


# Powerlevel10k (Powerlevel9k) {
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\e[1;244m\e[0m"
if [ "$UID" -eq 0 ]; then
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="# "
else
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "
fi
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( \
  ssh \
  context \
  virtualenv \
  rbenv \
  dir_writable \
  dir \
  vcs \
  status \
  root_indicator \
  background_jobs \
  time \
)
# }


# zsh-autosuggestions {
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#93a1a1"

# Workaround for Random ←[?1h is showing
# https://github.com/zsh-users/zsh-autosuggestions/issues/614
unset ZSH_AUTOSUGGEST_USE_ASYNC
# }


# rvm {
if [ -s "${HOME}/.rvm/scripts/rvm" ]; then
  source "${HOME}/.rvm/scripts/rvm"
fi
# }


# Python Poetry executables {
if [ -d "${HOME}/.poetry/bin" ]; then
  export PATH="${HOME}/.poetry/bin:${PATH}"
fi
# }


# .zshrc.light (configs for light background terminals) {
if [ -r "${HOME}/.zshrc.light" ]; then
  source "${HOME}/.zshrc.light"
fi
# }


# fd-find {
if command -v fdfind &>/dev/null; then
  alias fd=fdfind
fi
# }
