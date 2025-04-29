# General {
## Redefine ctrl-d to delete the character under the cursor
bind \cd delete-char

## locale
if not set -q LANG
    set -x LANG en_US.UTF-8
end
if not set -q LC_ALL
    set -x LC_ALL en_US.UTF-8
end

## bin
fish_add_path $HOME/bin
if test -d $HOME/bin.d
    for d in $HOME/bin.d/*
        if test -d $d -o -L $d
            fish_add_path $d
        end
    end
end
# } General


# Homebrew {
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end
# } Homebrew


# fd-find {
if type -q fdfind
    alias fd fdfind
end

switch (string lower (uname -o))
    case "cygwin*" "msys*"
        alias fd "fd --path-separator=//"
end
# } fd-find


# neovim {
if type -q nvim
    set -x EDITOR nvim
    set -x VISUAL nvim
end
# } neovim


# ripgrep {
switch (string lower (uname -o))
    case "cygwin*" "msys*"
        alias rg "rg --path-separator=//"
end
# } ripgrep


# zoxide {
if type -q zoxide
    zoxide init fish | source
end
# } zoxide


# Go {
if test -d $HOME/go/bin
    fish_add_path $HOME/go/bin
end
# } Go


# Python {
## User executables
switch (string lower (uname -o))
    case "cygwin*" "msys*"
        if test -d $HOME/AppData/Roaming/Python
            for d in $HOME/AppData/Roaming/Python/*/Scripts
                if test -d $d
                    fish_add_path $d
                end
            end
        end
    case "darwin*"
        if test -d $HOME/Library/Python
            for d in $HOME/Library/Python/*/bin
                if test -d $d
                    fish_add_path $d
                end
            end
        end
        if test -d /Library/Frameworks/Python.framework/Versions/Current/bin
            fish_add_path /Library/Frameworks/Python.framework/Versions/Current/bin
        end
end

## pyenv
if not test -x pyenv; and test -d $HOME/.pyenv
    set -x PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
end
if status --is-interactive; and test -x pyenv
    pyenv init - | source
    pyenv virtualenv-init - | source
end
# } Python


# Android SDK {
if test -d $HOME/Android/Sdk
    set -x ANDROID_HOME $HOME/Android/Sdk
else if test -d $HOME/Library/Android/sdk
    set -x ANDROID_HOME $HOME/Library/Android/sdk
end

if set -q ANDROID_HOME
    fish_add_path $ANDROID_HOME/tools
    fish_add_path $ANDROID_HOME/tools/bin
    fish_add_path $ANDROID_HOME/platform-tools
end
# } Android SDK
