# Environment varialbes {{{
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

test -d ~/bin ; and set PATH ~/bin $PATH
test -d ~/.cabal/bin ; and set PATH ~/.cabal/bin $PATH
test -d ~/.rvm/bin ; and set PATH ~/.rvm/bin $PATH
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
test -d $GOBIN ; and set PATH $GOBIN $PATH
# }}}

# Darwin specific tweaks {{{
if [ (uname) = Darwin ]
    # ls color
    alias ls='ls -G'
    # updatedb
    alias updatedb='sudo /usr/libexec/locate.updatedb'
end
# }}}

# Android Studio {{{
test -d ~/sdk/android-sdk-linux \
    ; and set PATH ~/sdk/android-sdk-linux/tools ~/sdk/android-sdk-linux/platform-tools $PATH
    ; and set -x ANDROID_HOME ~/sdk/android-sdk-linux
test -d ~/Library/Android/sdk \
    ; and set PATH ~/Library/Android/sdk/tools ~/Library/Android/sdk/platform-tools $PATH
    ; and set -x ANDROID_HOME ~/Library/Android/sdk
# }}}

# Java {{{
test -d /usr/lib/jvm/java-7-oracle \
    ; and set -x JAVA7_HOME /usr/lib/jvm/java-7-oracle
test -d "/Library/Java/JavaVirtualMachines/jdk1.7"*".jdk/Contents/Home" \
    ; and set -x JAVA7_HOME (echo "/Library/Java/JavaVirtualMachines/jdk1.7"*".jdk/Contents/Home")
test -d /usr/lib/jvm/java-8-oracle \
    ; and set -x JAVA8_HOME /usr/lib/jvm/java-8-oracle
test -d "/Library/Java/JavaVirtualMachines/jdk1.8"*".jdk/Contents/Home" \
    ; and set -x JAVA8_HOME (echo "/Library/Java/JavaVirtualMachines/jdk1.8"*".jdk/Contents/Home")
if [ $JAVA8_HOME ]
    set -gx JAVA_HOME $JAVA8_HOME
else if [ $JAVA7_HOME ]
    set -gx JAVA_HOME $JAVA7_HOME
end
# }}}
