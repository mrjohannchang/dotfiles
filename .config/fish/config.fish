function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
    if test "$PWD" != "$HOME"
        printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
    else
        echo '~'
    end
end

function fish_prompt
    # Cache exit status
    set -l last_status $status

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_char
        switch (id -u)
        case 0
            set -g __fish_prompt_char '#'
        case '*'
            set -g __fish_prompt_char '$'
        end
    end

    # Setup colors
    set -l bold (set_color -o)
    set -l normal (set_color normal)
    set -l black (set_color -o black)
    set -l blue (set_color -o blue)
    set -l brown (set_color -o brown)
    set -l cyan (set_color -o cyan)
    set -l green (set_color -o green)
    set -l magenta (set_color -o magenta)
    set -l purple (set_color -o purple)
    set -l red (set_color -o red)
    set -l white (set_color -o white)
    set -l yellow (set_color -o yellow)
    if tput setaf 1 > /dev/null ^&1
        set bold (tput bold)
        set reset (tput sgr0)
        # Solarized colors, taken from http://git.io/solarized-colors.
        set black (tput setaf 0)
        set blue (tput setaf 33)
        set brown (tput setaf 166)
        set cyan (tput setaf 37)
        set green (tput setaf 64)
        set magenta (tput setaf 61)
        set purple (tput setaf 125)
        set red (tput setaf 124)
        set white (tput setaf 15)
        set yellow (tput setaf 136)
    end

    # Configure __fish_git_prompt
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_showcolorhints true

    set -l user_style $brown
    if [ (id -u) -eq 0 ]
        set user_style $red
    end

    set -l host_style $yellow
    if set -q SSH_TTY
        set host_style $bold$red
    end

    # Color prompt char red for non-zero exit status
    set -l pcolor $normal
    if [ $last_status -ne 0 ]
      set pcolor $red
    end

    set -l _date (printf '%s' (date "+%a %b %d"))
    set -l _time (printf '%s' (date +%H:%M:%S))

    # Top
    echo -n "⋊>" $user_style$USER$normal at $host_style$__fish_prompt_hostname$normal in $bold$blue(prompt_pwd)$normal
    __fish_git_prompt
    echo -n "" since $green$_date $cyan$_time$normal

    echo

    # Bottom
    echo -n $pcolor$__fish_prompt_char $normal
end
