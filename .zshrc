# {{{ Powerlevel9k
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_COLOR_SCHEME='light'
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\e[1;97;47m\e[0m"
if [ "$UID" -eq 0 ]; then
  POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="# "
else
  POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="$ "
fi
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( \
  ssh \
  context \
  dir_writable \
  dir \
  rbenv \
  vcs \
  status \
  root_indicator \
  background_jobs \
  time \
)
# }}}


# MISC {{{
# This options works like APPEND_HISTORY except that new history lines are
# added to the $HISTFILE incrementally (as soon as they are entered),
# rather than waiting until the shell exits.
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
# }}}


# Disable ctrl-d {{{
setopt IGNORE_EOF
# }}}


# {{{ zplug
source ~/.zplug/init.zsh

zplug "bhilburn/powerlevel9k", as:theme
zplug "rupa/z", use:z.sh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Enable all oh-my-zsh's features
zplug "lib/*", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
# }}}
