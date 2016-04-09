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
HISTSIZE=10000
HISTFILESIZE=20000

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

if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# Binding C-t to fire search forward {{{
bind '"\C-t": forward-search-history'
# }}}

__my_fancy_cwd()
{
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
  true
  # PROMPT_COMMAND='echo -ne "\033k[$(__my_fancy_cwd)]\033\\"'
fi

if [ -d ~/.bash_completion.d ]; then
  for file in ~/.bash_completion.d/*; do
    . $file
  done
fi

[[ -d $HOME/sdk/android-sdk-linux ]] \
  && PATH="$PATH:$HOME/sdk/android-sdk-linux/tools:$HOME/sdk/android-sdk-linux/platform-tools" \
  && export ANDROID_HOME=$HOME/sdk/android-sdk-linux
[[ -d $HOME/Library/Android/sdk ]] \
  && PATH="$PATH:$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools" \
  && export ANDROID_HOME=$HOME/Library/Android/sdk

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

# Add node.js executables {{{
[[ -d "$HOME/node_modules/.bin" ]] \
  && PATH="$PATH:$HOME/node_modules/.bin"
# }}}

# Go {{{
export GOPATH=$HOME/.go
export GOBIN=${GOPATH}/bin
[[ -d ${GOBIN} ]] \
  && PATH="$PATH:$GOBIN"
# }}}

# Java {{{
if [ -d "/usr/lib/jvm/java-7-oracle" ]; then
  export JAVA7_HOME="/usr/lib/jvm/java-7-oracle"
elif [ -d "/Library/Java/JavaVirtualMachines/jdk1.7"*".jdk/Contents/Home" ]; then
  export JAVA7_HOME=$(echo "/Library/Java/JavaVirtualMachines/jdk1.7"*".jdk/Contents/Home")
fi
if [ -d "/usr/lib/jvm/java-8-oracle" ]; then
  export JAVA8_HOME="/usr/lib/jvm/java-8-oracle"
elif [ -d "/Library/Java/JavaVirtualMachines/jdk1.8"*".jdk/Contents/Home" ]; then
  export JAVA8_HOME=$(echo "/Library/Java/JavaVirtualMachines/jdk1.8"*".jdk/Contents/Home")
fi
if [ -n $JAVA8_HOME ]; then
  export JAVA_HOME="$JAVA8_HOME"
elif [ -n $JAVA7_HOME ]; then
  export JAVA_HOME="$JAVA7_HOME"
fi
# }}}

# Node Version Manager {{{
if [ -f ~/.nvm/nvm.sh ]; then
  . ~/.nvm/nvm.sh
fi
# }}}

# Darwin specific tweaks
if [[ "${OSTYPE,,}" == darwin* ]]; then
  # ls color
  alias ls='ls -G'
  # updatedb
  alias updatedb='sudo /usr/libexec/locate.updatedb'
fi

# Bash prompt {{{
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM='xterm-256color';
fi

__my_prompt_git()
{
  local s='';
  local branchName='';

  # Check if the current directory is in a Git repository.
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

      # Ensure the index is up to date.
      git update-index --really-refresh -q &>/dev/null;

      # Check for uncommitted changes in the index.
      if ! $(git diff --quiet --ignore-submodules --cached); then
        s+='+';
      fi;

      # Check for unstaged changes.
      if ! $(git diff-files --quiet --ignore-submodules --); then
        s+='!';
      fi;

      # Check for untracked files.
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        s+='?';
      fi;

      # Check for stashed files.
      if $(git rev-parse --verify refs/stash &>/dev/null); then
        s+='$';
      fi;

    fi;

    # Get the short symbolic ref.
    # If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
    # Otherwise, just give up.
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
        git rev-parse --short HEAD 2> /dev/null || \
        echo '(unknown)')";

    [ -n "${s}" ] && s=" [${s}]";

    echo -e "${1}${branchName}${purple}${s}";
  else
    return;
  fi;
}

__my_prompt_sign()
{
  if [ $(id -u) -eq 0 ]; then
    echo '#'
  else
    echo '$'
  fi
}

__my_ps1()
{
  if tput setaf 1 &> /dev/null; then
    tput sgr0 # reset colors
    bold=$(tput bold)
    reset=$(tput sgr0)
    # Solarized colors, taken from http://git.io/solarized-colors.
    black=$(tput setaf 0)
    blue=$(tput setaf 33)
    cyan=$(tput setaf 37)
    green=$(tput setaf 64)
    orange=$(tput setaf 166)
    purple=$(tput setaf 125)
    red=$(tput setaf 124)
    violet=$(tput setaf 61)
    white=$(tput setaf 15)
    yellow=$(tput setaf 136)
  else
    bold=''
    reset="\e[0m"
    black="\e[1;30m"
    blue="\e[1;34m"
    cyan="\e[1;36m"
    green="\e[1;32m"
    orange="\e[1;33m"
    purple="\e[1;35m"
    red="\e[1;31m"
    violet="\e[1;35m"
    white="\e[1;37m"
    yellow="\e[1;33m"
  fi

  # Highlight the user name when logged in as root.
  if [[ "${USER}" == "root" ]]; then
    userStyle="${red}"
  else
    userStyle="${orange}"
  fi

  # Highlight the hostname when connected via SSH.
  if [[ "${SSH_TTY}" ]]; then
    hostStyle="${bold}${red}"
  else
    hostStyle="${yellow}"
  fi

  # Set the terminal title to the current working directory.
  PS1="\[\033]0;\w\007\]"
  PS1+="\[${userStyle}\]\u" # username
  PS1+="\[${reset}\] at "
  PS1+="\[${hostStyle}\]\h" # host
  PS1+="\[${reset}\] in "
  PS1+="\[${bold}${blue}\]\w" # working directory
  PS1+="\$(__my_prompt_git \"${reset} on ${violet}\")" # Git repository details
  PS1+="\[${reset}\] since "
  PS1+="\[${green}\]\d \[${cyan}\]\t" # date
  PS1+="\n"
  PS1+="\[${reset}\]\$(__my_prompt_sign) \[${reset}\]" # `$` or `#` (and reset color)
  echo -n "${PS1}"
}

__my_ps2()
{
  if tput setaf 1 &> /dev/null; then
    tput sgr0 # reset colors
    bold=$(tput bold)
    reset=$(tput sgr0)
    # Solarized colors, taken from http://git.io/solarized-colors.
    black=$(tput setaf 0)
    blue=$(tput setaf 33)
    cyan=$(tput setaf 37)
    green=$(tput setaf 64)
    orange=$(tput setaf 166)
    purple=$(tput setaf 125)
    red=$(tput setaf 124)
    violet=$(tput setaf 61)
    white=$(tput setaf 15)
    yellow=$(tput setaf 136)
  else
    bold=''
    reset="\e[0m"
    black="\e[1;30m"
    blue="\e[1;34m"
    cyan="\e[1;36m"
    green="\e[1;32m"
    orange="\e[1;33m"
    purple="\e[1;35m"
    red="\e[1;31m"
    violet="\e[1;35m"
    white="\e[1;37m"
    yellow="\e[1;33m"
  fi
  echo -n "\[${yellow}\]→ \[${reset}\]"
}

PS1=$(__my_ps1)
export PS1
PS2=$(__my_ps2)
export PS2

unset -f __my_ps1
unset -f __my_ps2
# }}}

# gpg-agent {{{
__get_gpg_agent_sock()
{
  __gpg_agent_info_file="${1}"
  cat "${__gpg_agent_info_file}" | while IFS='' read -r line || [ -n "${line}" ]; do
    if echo -n "${line}" | grep -q "S\.gpg-agent" > /dev/null 2>&1; then
      echo -n "${line}" | sed 's/.*\(\/tmp\/gpg.*\/S\.gpg-agent\).*/\1/'
      break
    fi
  done
}

__get_gpg_agent_info()
{
  __gpg_agent_info_file="${1}"
  cat "${__gpg_agent_info_file}" | while IFS='' read -r line || [ -n "${line}" ]; do
    if echo -n "${line}" | grep -q "S\.gpg-agent" > /dev/null 2>&1; then
      echo -n "${line}" | sed 's/GPG_AGENT_INFO=//' | sed 's/; export GPG_AGENT_INFO;//'
      break
    fi
  done
}

__gpg_agent_info_file="${HOME}/.gpg-agent-info"

if [ -f "${__gpg_agent_info_file}" ]; then
  __gpg_agent_info=$(__get_gpg_agent_info "${__gpg_agent_info_file}")
  __gpg_agent_sock=$(__get_gpg_agent_sock "${__gpg_agent_info_file}")
  if [ -S "${__gpg_agent_sock}" ]; then
    GPG_AGENT_INFO="${__gpg_agent_info}"
    export GPG_AGENT_INFO
  fi
else
  if [ -n "${GPG_AGENT_INFO}" ]; then
    __gpg_agent_sock=$(__get_gpg_agent_sock <(echo -n ${GPG_AGENT_INFO}))
    if [ ! -S "${__gpg_agent_sock}" ]; then
      unset GPG_AGENT_INFO
    fi
  fi
fi

if [ -z "${GPG_AGENT_INFO}" ]; then
  rm -rf "${__gpg_agent_info_file}"
  pgrep -U "$(id -u)"  gpg-agent | while read line; do
    kill "${line}"
  done
  command -v gpg-agent && gpg-agent --daemon --sh --default-cache-ttl 7200 > "${__gpg_agent_info_file}"
  GPG_AGENT_INFO=$(__get_gpg_agent_info "${__gpg_agent_info_file}")
  export GPG_AGENT_INFO
fi

unset __gpg_agent_sock
unset __gpg_agent_info
unset -f __get_gpg_agent_sock
unset -f __get_gpg_agent_info
unset __gpg_agent_info_file
# }}}
