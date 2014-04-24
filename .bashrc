# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Enable 256 color.
case "$TERM" in
    xterm*) TERM=xterm-256color
esac

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi



# The below are custom settings

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

colors() {
  local DEFAULT="\[\033[0m\]"
  local BRIGHT="\[\033[1;37m\]"
  local BLACK="\[\033[0;30m\]"
  local LIGHT_BLACK="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local LIGHT_RED="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local LIGHT_YELLOW="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local LIGHT_BLUE="\[\033[1;34m\]"
  local MAGENTA="\[\033[0;35m\]"
  local LIGHT_MAGENTA="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local LIGHT_CYAN="\[\033[1;36m\]"
  case $TERM in
    xterm*|rxvt*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

  PS1="${TITLEBAR}\
$LIGHT_RED\u$DEFAULT@$LIGHT_GREEN\h$DEFAULT:$LIGHT_BLUE\w$DEFAULT\
\$(__git_ps1 \"($GREEN%s$DEFAULT)\")[$CYAN\d$DEFAULT $YELLOW\t$DEFAULT]\n"
  if [ $USER = root ]; then
      PS1="$PS1# "
  else
      PS1="$PS1\$ "
  fi
}
colors

# Binding C-t to fire search forward {{{
bind '"\C-t": forward-search-history'
# }}}

fancycwd() {
    if [ "$PWD" = "/" ] \
        || [ "$(dirname "$PWD")" = "/" ] \
        || [ "$(dirname "$(dirname "$PWD")")" = "/" ] \
        && [ ! "$PWD" = "$HOME" ]; then
        echo -ne "$PWD"
    elif [ "$PWD" = "$HOME" ]; then
        echo -ne "~"
    elif [ "$(dirname "$PWD")" = "$HOME" ]; then
        echo -ne ""~"/$(basename "$PWD")"
    elif [ "$(dirname "$(dirname "$PWD")")" = "$HOME" ]; then
        echo -ne ""~"/$(basename "$(dirname "$PWD")")/$(basename "$PWD")"
    else
        echo -ne "$(basename "$(dirname "$PWD")")/$(basename "$PWD")"
    fi;
}

if [ ! -z $TMUX ]; then
    PROMPT_COMMAND='echo -ne "\033k[$(fancycwd)]\033\\"'
fi

if [ -d ~/.bash_completion.d ]; then
    for file in ~/.bash_completion.d/*; do
        . $file
    done
fi

[[ -d $HOME/sdk/android-sdk-linux ]] \
    && PATH="$PATH:$HOME/sdk/android-sdk-linux/tools:$HOME/sdk/android-sdk-linux/platform-tools"

[[ -d $HOME/.cabal/bin ]] \
    && PATH="$PATH:$HOME/.cabal/bin"

[[ -d $HOME/.rvm/bin ]] \
    && PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] \
    && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# for virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
[[ -f /usr/local/bin/virtualenvwrapper.sh ]] \
    && source /usr/local/bin/virtualenvwrapper.sh

mkdircd() { mkdir -p "$@" && eval cd "\"\$$#\""; }

[ -f "$HOME/.dircolorsdb" ] && eval $(dircolors "$HOME/.dircolorsdb")

# Refresh SSH agent in case it was dead {{{
if [ ! -z "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/agent_sock" ] ; then
    unlink "$HOME/.ssh/agent_sock" 2>/dev/null
    ln -s "$SSH_AUTH_SOCK" "$HOME/.ssh/agent_sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/agent_sock"
fi
# }}}
