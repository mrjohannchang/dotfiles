#!/usr/bin/env bash

set -e

COLOR_RESET=$(tput sgr0)
COLOR_RED=$(tput setaf 124)
COLOR_BOLD=$(tput bold)

ERR() {
    echo -e ${COLOR_BOLD}${COLOR_RED}ERROR${COLOR_RESET} "$@" >&2
    exit 2
}

INFO() {
    echo -e ${COLOR_BOLD}INFO${COLOR_RESET} "$@"
}

entry_point="$0"
file_name="$BASH_SOURCE"

if [[ "$entry_point" = *bash ]]; then
    ERR "file sourced by shell not executed"
fi

if [[ $(basename "$file_name") = "install"* ]]; then
    install=1
elif [[ $(basename "$file_name") = "uninstall"* ]]; then
    uninstall=1
fi

install() {
    INFO "begin to install"

    if [ -e ~/.bash_completion.d ] && [ ! -L ~/.bash_completion.d ]; then
        rm -rf ~/.bash_completion.d.bak
        mv ~/.bash_completion.d ~/.bash_completion.d.bak
    fi
    ln -fs "$PWD"/.bash_completion.d ~/.bash_completion.d
    echo ".bash_completion.d installed"

    if [ -e ~/.bashrc ] && [ ! -L ~/.bashrc ]; then
        rm -rf ~/.bashrc.bak
        mv ~/.bashrc ~/.bashrc.bak
    fi
    ln -fs "$PWD"/.bashrc ~/.bashrc
    echo ".bashrc installed"

    if [ -e ~/.pentadactylrc ] && [ ! -L ~/.pentadactylrc ]; then
        rm -rf ~/.pentadactylrc.bak
        mv ~/.pentadactylrc ~/.pentadactylrc.bak
    fi
    ln -fs "$PWD"/.pentadactylrc ~/.pentadactylrc
    echo ".pentadactylrc installed"

    if [ -e ~/.profile ] && [ ! -L ~/.profile ]; then
        rm -rf ~/.profile.bak
        mv ~/.profile ~/.profile.bak
    fi
    ln -fs "$PWD"/.profile ~/.profile
    echo ".profile installed"

    if [ -e ~/.tmux ] && [ ! -L ~/.tmux ]; then
        rm -rf ~/.tmux.bak
        mv ~/.tmux ~/.tmux.bak
    fi
    ln -fs "$PWD"/.tmux ~/.tmux
    echo ".tmux installed"

    if [ -e ~/.tmux.conf ] && [ ! -L ~/.tmux.conf ]; then
        rm -rf ~/.tmux.conf.bak
        mv ~/.tmux.conf ~/.tmux.conf.bak
    fi
    ln -fs "$PWD"/.tmux.conf ~/.tmux.conf
    echo ".tmux.conf installed"

    if [ -e ~/.vim ] && [ ! -L ~/.vim ]; then
        rm -rf ~/.vim.bak
        mv ~/.vim ~/.vim.bak
    fi
    ln -fs "$PWD"/.vim ~/.vim
    echo ".vim installed"

    if [ -e ~/.vimrc ] && [ ! -L ~/.vimrc ]; then
        rm -rf ~/.vimrc.bak
        mv ~/.vimrc ~/.vimrc.bak
    fi
    ln -fs "$PWD"/.vimrc ~/.vimrc
    echo ".vimrc installed"

    if [ -e ~/.vimperatorrc ] && [ ! -L ~/.vimperatorrc ]; then
        rm -rf ~/.vimperatorrc.bak
        mv ~/.vimperatorrc ~/.vimperatorrc.bak
    fi
    ln -fs "$PWD"/.vimperatorrc ~/.vimperatorrc
    echo ".vimperatorrc installed"

    if [ ! -e ~/.config ]; then
        mkdir ~/.config
    fi

    if [ -e ~/.config/omf ] && [ ! -L ~/.config/omf ]; then
        rm -rf ~/.config/omf.bak
        mv ~/.config/omf ~/.config/omf.bak
    fi
    ln -fs "$PWD"/.config/omf ~/.config/omf
    echo ".config/omf installed"

    if [[ "${OSTYPE,,}" == linux* ]]; then
        echo -n "Install Solaried dircolorsdb [y/N]? "
        read ans
        if [ "${ans,,}" = "y" ]; then
            if [ -e ~/.dircolorsdb ] && [ ! -L ~/.dircolorsdb ]; then
                rm -rf ~/.dircolorsdb.bak
                mv ~/.dircolorsdb ~/.dircolorsdb.bak
            fi
            ln -fs "$PWD"/bundle/dircolors-solarized/dircolors.ansi-light ~/.dircolorsdb
            echo ".dircolorsdb installed"
        fi

        echo "Installing Solarized color scheme to current Gnome Terminal profile,"
        echo -n "this cannot be undone. Proceed to install [y/N]? "
        read ans
        if [ "${ans,,}" = "y" ]; then
            bundle/gnome-terminal-colors-solarized/set_light.sh
            echo "Gnome Terminal is now solarized"
        fi

        if [ ! -d ~/.fonts ]; then
            rm -rf ~/.fonts
            mkdir ~/.fonts
        fi

        if [ ! -d ~/.config/fontconfig/conf.d ]; then
            rm -rf ~/.config/fontconfig/conf.d
            mkdir -p ~/.config/fontconfig/conf.d
        fi
        ln -fs "$PWD"/.fonts/PowerlineSymbols.otf ~/.fonts
        ln -fs "$PWD"/.config/fontconfig/conf.d/10-powerline-symbols.conf ~/.config/fontconfig/conf.d
        echo "Powerline's font installed"

        ln -fs "$PWD"/.config/fontconfig/conf.d/20-noto-cjk.conf ~/.config/fontconfig/conf.d
        echo "Noto Sans' fontconfig installed"
    elif [[ "${OSTYPE,,}" == darwin* ]]; then
        if [ -d ~/Library/Fonts ]; then
            ln -fs "$PWD/.fonts/Monaco for Powerline.otf" ~/Library/Fonts
            echo "font \"Monaco for Powerline.otf\" installed"
        fi
    fi

    INFO "installation completed"
}

uninstall() {
    INFO "begin to uninstall"

    if [ -L ~/.bash_completion.d ]; then
        unlink ~/.bash_completion.d
        if [ -e ~/.bash_completion.d.bak ]; then
            mv ~/.bash_completion.d.bak ~/.bash_completion.d
        fi
        echo ".bash_completion.d uninstalled"
    fi

    if [ -L ~/.bashrc ]; then
        unlink ~/.bashrc
        if [ -e ~/.bashrc.bak ]; then
            mv ~/.bashrc.bak ~/.bashrc
        fi
        echo ".bashrc uninstalled"
    fi

    if [ -L ~/.pentadactylrc ]; then
        unlink ~/.pentadactylrc
        if [ -e ~/.pentadactylrc.bak ]; then
            mv ~/.pentadactylrc.bak ~/.pentadactylrc
        fi
        echo ".pentadactylrc uninstalled"
    fi

    if [ -L ~/.profile ]; then
        unlink ~/.profile
        if [ -e ~/.profile.bak ]; then
            mv ~/.profile.bak ~/.profile
        fi
        echo ".profile uninstalled"
    fi

    if [ -L ~/.tmux ]; then
        unlink ~/.tmux
        if [ -e ~/.tmux.bak ]; then
            mv ~/.tmux.bak ~/.tmux
        fi
        echo ".tmux uninstalled"
    fi

    if [ -L ~/.tmux.conf ]; then
        unlink ~/.tmux.conf
        if [ -e ~/.tmux.conf.bak ]; then
            mv ~/.tmux.conf.bak ~/.tmux.conf
        fi
        echo ".tmux.conf uninstalled"
    fi

    if [ -L ~/.vim ]; then
        unlink ~/.vim
        if [ -e ~/.vim.bak ]; then
            mv ~/.vim.bak ~/.vim
        fi
        echo ".vim uninstalled"
    fi

    if [ -L ~/.vimrc ]; then
        unlink ~/.vimrc
        if [ -e ~/.vimrc.bak ]; then
            mv ~/.vimrc.bak ~/.vimrc
        fi
        echo ".vimrc uninstalled"
    fi

    if [ -L ~/.vimperatorrc ]; then
        unlink ~/.vimperatorrc
        if [ -e ~/.vimperatorrc.bak ]; then
            mv ~/.vimperatorrc.bak ~/.vimperatorrc
        fi
        echo ".vimperatorrc uninstalled"
    fi

    if [ -L ~/.config/omf ]; then
        unlink ~/.config/omf
        if [ -e ~/.config/omf.bak ]; then
            mv ~/.config/omf.bak ~/.config/omf
        fi
        echo ".config/omf uninstalled"
    fi

    if [[ "${OSTYPE,,}" == linux* ]]; then
        if [ -L ~/.dircolorsdb ]; then
            unlink ~/.dircolorsdb
            echo "dircolorsdb uninstalled"
        fi

        if [ -L ~/.fonts/PowerlineSymbols.otf ] ||
            [ -L ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]; then
            if [ -L ~/.fonts/PowerlineSymbols.otf ]; then
                unlink ~/.fonts/PowerlineSymbols.otf
            fi
            if [ -L ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]; then
                unlink ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
            fi
            echo "Powerline's font uninstalled"
        fi

        if [ -L ~/.config/fontconfig/conf.d/20-noto-cjk.conf ]; then
            unlink ~/.config/fontconfig/conf.d/20-noto-cjk.conf
            echo "Noto Sans' fontconfig uninstalled"
        fi
    elif [[ "${OSTYPE,,}" == darwin* ]]; then
        if [ -L "~/Library/Fonts/Monaco for Powerline.otf" ]; then
            unlink "~/Library/Fonts/Monaco for Powerline.otf"
            echo "font \"Monaco for Powerline.otf\" uninstalled"
        fi
    fi

    INFO "uninstallation completed"
}

cd $(dirname "$file_name")

if [[ $install ]]; then
    uninstall
    install
elif [[ $uninstall ]]; then
    uninstall
fi
