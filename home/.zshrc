# misc {
export CASE_SENSITIVE=true
if [[ "${OSTYPE:l}" == msys* ]]; then
  export CASE_SENSITIVE=false
fi

# disable ctrl-d
setopt IGNORE_EOF

# HIST_IGNORE_ALL_DUPS: If a new command line being added to the history list
# duplicates an older one, the older command is removed from the list (even if
# it is not the previous event).
setopt HIST_IGNORE_ALL_DUPS

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
# }


# Powerlevel9k {
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_COLOR_SCHEME="light"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\e[1;97;47m\e[0m"
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


# zsh-history-substring-search {
bindkey -M emacs "^P" history-substring-search-up
bindkey -M emacs "^N" history-substring-search-down
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

  znap source zsh-users/zsh-syntax-highlighting
fi
# }


# # { zplug
# source ~/.zplug/init.zsh
# 
# zplug "bhilburn/powerlevel9k", as:theme
# zplug "changyuheng/fz", defer:1
# # zplug "changyuheng/zsh-interactive-cd"
# zplug "rupa/z", use:z.sh
# zplug "supercrabtree/k"
# zplug "Tarrasch/zsh-bd"
# # zplug "zdharma/fast-syntax-highlighting", defer:2
# # zplug "zsh-users/zsh-autosuggestions"
# zplug "zsh-users/zsh-completions"
# zplug "zsh-users/zsh-history-substring-search", defer:3
# zplug "zsh-users/zsh-syntax-highlighting", defer:2
# 
# # Enable specific oh-my-zsh's features
# zplug "lib/bzr", from:oh-my-zsh
# zplug "lib/clipboard", from:oh-my-zsh
# zplug "lib/compfix", from:oh-my-zsh
# zplug "lib/completion", from:oh-my-zsh
# zplug "lib/correction", from:oh-my-zsh
# zplug "lib/functions", from:oh-my-zsh
# zplug "lib/history", from:oh-my-zsh
# zplug "lib/key-bindings", from:oh-my-zsh
# zplug "lib/nvm", from:oh-my-zsh
# zplug "lib/prompt_info_functions", from:oh-my-zsh
# zplug "lib/spectrum", from:oh-my-zsh
# zplug "plugins/docker", from:oh-my-zsh
# zplug "plugins/docker-compose", from:oh-my-zsh
# # zplug "plugins/gpg-agent", from:oh-my-zsh
# zplug "plugins/nvm", from:oh-my-zsh
# zplug "plugins/pyenv", from:oh-my-zsh
# zplug "plugins/rvm", from:oh-my-zsh
# 
# # Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi
# 
# # Then, source plugins and add commands to $PATH
# zplug load
# # }


# autosuggestions {
# this has to be done after the plugin being loaded
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
  beginning-of-line
  backward-delete-char
  backward-delete-word
  backward-kill-word
  history-search-forward
  history-search-backward
  history-beginning-search-forward
  history-beginning-search-backward
  history-substring-search-up
  history-substring-search-down
  up-line-or-history
  down-line-or-history
  accept-line
)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=black,bold,underline"
# }

# macOS {
if [[ "${OSTYPE:l}" == darwin* ]]; then
  # ls color
  if command -v gdircolors &>/dev/null; then
    if [ -r "${HOME}/.dircolors" ]; then
      eval "$(gdircolors -b "${HOME}/.dircolors" 2>/dev/null)" || eval "$(gdircolors -b)"
      alias ls="gls --quoting-style=literal --color=auto"
    fi
  fi

  # updatedb
  alias updatedb="sudo /usr/libexec/locate.updatedb"
fi
# }


# fast-syntax-highlighting {
# FAST_HIGHLIGHT_STYLES[variable]="fg=blue"
zle_highlight+=(paste:none)
# }


# rvm {
if [ -s "${HOME}/.rvm/scripts/rvm" ]; then
  source "${HOME}/.rvm/scripts/rvm"
fi
# }


# locale {
[[ -n "$LANG" ]] || export LANG=en_US.UTF-8
[[ -n "$LC_ALL" ]] || export LC_ALL=en_US.UTF-8
# }


# Snappy binary dir {
if [ -d "/snap/bin" ]; then
  export PATH="/snap/bin:${PATH}"
fi
# }


# Python Poetry executables {
if [ -d "${HOME}/.poetry/bin" ]; then
  export PATH="${HOME}/.poetry/bin:${PATH}"
fi
# }


# fd-find {
if command -v fdfind &>/dev/null; then
  alias fd=fdfind
fi
# }


# .zshrc.light (configs for light background terminals) {
if [ -r "${HOME}/.zshrc.light" ]; then
  source "${HOME}/.zshrc.light"
fi
# }
