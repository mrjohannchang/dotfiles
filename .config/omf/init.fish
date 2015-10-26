# Environment varialbes {{{
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

test -d ~/bin ; and set -x PATH ~/bin $PATH
test -d ~/.cabal/bin ; and set -x PATH ~/.cabal/bin $PATH
test -d ~/.rvm/bin ; and set -x PATH ~/.rvm/bin $PATH
# }}}


# Functions {{{
function l ; tree --dirsfirst -aFCNL 1 $argv ; end
function ll ; tree --dirsfirst -ChFupDaLg 1 $argv ; end
function mkdircd ; mkdir -p "$argv[1..-1]" ; and cd "$argv[1..-1]" ; end
# }}}


# Tmux {{{
if [ $TMUX ]
    set -g PROMPT_COMMAND 'echo -ne "\033k[(prompt_pwd)]\033\\"'
end
# }}}


# Go {{{
set -x GOPATH ~/.go
set -x GOBIN $GOPATH/bin
test -d $GOBIN ; and set -x PATH $GOBIN $PATH
# }}}


# Darwin specific tweaks {{{
if [ (uname) = Darwin ]
    # ls color
    alias ls='ls -G'
    # updatedb
    alias updatedb='sudo /usr/libexec/locate.updatedb'
end
# }}}
