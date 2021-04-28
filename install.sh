#!/usr/bin/env bash

set -e

script_dir=$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)

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

if [[ "$entry_point" = *bash ]]; then
    ERR "file sourced by shell not executed"
fi

if [[ $(basename "$BASH_SOURCE") = "install"* ]]; then
    install=1
elif [[ $(basename "$BASH_SOURCE") = "uninstall"* ]]; then
    uninstall=1
fi

install() {
    INFO "begin to install"

    if [ -e ~/.bash_completion.d ] && [ ! -L ~/.bash_completion.d ]; then
        rm -rf ~/.bash_completion.d.bak
        mv ~/.bash_completion.d ~/.bash_completion.d.bak
    fi
    ln -fs "$script_dir"/.bash_completion.d ~/.bash_completion.d
    echo ".bash_completion.d installed"

    if [ -e ~/.bashrc ] && [ ! -L ~/.bashrc ]; then
        rm -rf ~/.bashrc.bak
        mv ~/.bashrc ~/.bashrc.bak
    fi
    ln -fs "$script_dir"/.bashrc ~/.bashrc
    echo ".bashrc installed"

    if [ -e ~/.ideavimrc ] && [ ! -L ~/.ideavimrc ]; then
        rm -rf ~/.ideavimrc.bak
        mv ~/.ideavimrc ~/.ideavimrc.bak
    fi
    ln -fs "$script_dir"/.ideavimrc ~/.ideavimrc
    echo ".ideavimrc installed"

    if [ -e ~/.pentadactylrc ] && [ ! -L ~/.pentadactylrc ]; then
        rm -rf ~/.pentadactylrc.bak
        mv ~/.pentadactylrc ~/.pentadactylrc.bak
    fi
    ln -fs "$script_dir"/.pentadactylrc ~/.pentadactylrc
    echo ".pentadactylrc installed"

    if [ -e ~/.profile ] && [ ! -L ~/.profile ]; then
        rm -rf ~/.profile.bak
        mv ~/.profile ~/.profile.bak
    fi
    ln -fs "$script_dir"/.profile ~/.profile
    echo ".profile installed"

    if [ -e ~/.tmux ] && [ ! -L ~/.tmux ]; then
        rm -rf ~/.tmux.bak
        mv ~/.tmux ~/.tmux.bak
    fi
    ln -fs "$script_dir"/.tmux ~/.tmux
    echo ".tmux installed"

    if [ -e ~/.tmux.conf ] && [ ! -L ~/.tmux.conf ]; then
        rm -rf ~/.tmux.conf.bak
        mv ~/.tmux.conf ~/.tmux.conf.bak
    fi
    ln -fs "$script_dir"/.tmux.conf ~/.tmux.conf
    if [[ "${OSTYPE,,}" == darwin* ]]; then
      if [ -e ~/.tmux.darwin.conf ] && [ ! -L ~/.tmux.darwin.conf ]; then
          rm -rf ~/.tmux.darwin.conf.bak
          mv ~/.tmux.darwin.conf ~/.tmux.darwin.conf.bak
      fi
      ln -fs "$script_dir"/.tmux.darwin.conf ~/.tmux.darwin.conf
    fi
    echo ".tmux.conf installed"

    if [ -e ~/.vim ] && [ ! -L ~/.vim ]; then
        rm -rf ~/.vim.bak
        mv ~/.vim ~/.vim.bak
    fi
    ln -fs "$script_dir"/.vim ~/.vim
    echo ".vim installed"

    if [ -e ~/.vimrc ] && [ ! -L ~/.vimrc ]; then
        rm -rf ~/.vimrc.bak
        mv ~/.vimrc ~/.vimrc.bak
    fi
    ln -fs "$script_dir"/.vimrc ~/.vimrc
    echo ".vimrc installed"

    if [ -e ~/.vimperatorrc ] && [ ! -L ~/.vimperatorrc ]; then
        rm -rf ~/.vimperatorrc.bak
        mv ~/.vimperatorrc ~/.vimperatorrc.bak
    fi
    ln -fs "$script_dir"/.vimperatorrc ~/.vimperatorrc
    echo ".vimperatorrc installed"

    if [ ! -e ~/.config ]; then
        mkdir ~/.config
    fi

    echo -n "Install Git configurations (cannot be undone) [y/N]? "
    read ans
    if [ "${ans,,}" = "y" ]; then
         git config --global color.ui auto
         git config --global core.quotepath no
         git config --global diff.algorithm patience
         git config --global pull.ff only
         git config --global push.default simple
         git config --global alias.show-tracked-ignored "ls-files -i --exclude-standard"
    fi

    # echo -n "Install fisherman configurations (cannot be undone) [y/N]? "
    # read ans
    # if [ "${ans,,}" = "y" ]; then
        # echo -n "fisher update" | fish || true
        # echo -n "fisher install changyuheng/myfishconfig" | fish || true
        # echo -n "fisher install changyuheng/theme-plain" | fish || true
        # echo -n "fisher install edc/bass" | fish || true
        # echo -n "fisher install nvm" | fish || true
        # echo -n "fisher install pyenv" | fish || true
        # echo -n "fisher install z" | fish || true
    # fi

    echo -n "Install Solaried dircolorsdb [y/N]? "
    read ans
    if [ "${ans,,}" = "y" ]; then
        if [ -e ~/.dircolors ] && [ ! -L ~/.dircolors ]; then
            rm -rf ~/.dircolors.bak
            mv ~/.dircolors ~/.dircolors.bak
        fi
        ln -fs "$script_dir"/bundle/dircolors-solarized/dircolors.ansi-light ~/.dircolors
        echo ".dircolorsdb installed"
    fi

    if [[ "${OSTYPE,,}" == linux* ]]; then
        if [ ! -d ~/.fonts ]; then
            rm -rf ~/.fonts
            mkdir ~/.fonts
        fi

        if [ ! -d ~/.config/fontconfig/conf.d ]; then
            rm -rf ~/.config/fontconfig/conf.d
            mkdir -p ~/.config/fontconfig/conf.d
        fi
        ln -fs "$script_dir"/.fonts/PowerlineSymbols.otf ~/.fonts
        ln -fs "$script_dir"/.config/fontconfig/conf.d/10-powerline-symbols.conf ~/.config/fontconfig/conf.d
        echo "Powerline's font installed"

        ln -fs "$script_dir"/.config/fontconfig/conf.d/20-noto-cjk.conf ~/.config/fontconfig/conf.d
        echo "Noto Sans' fontconfig installed"
    elif [[ "${OSTYPE,,}" == darwin* ]]; then
        if [ -d ~/Library/Fonts ]; then
            ln -fs "$script_dir/.fonts/Monaco for Powerline.otf" ~/Library/Fonts
            echo "font \"Monaco for Powerline.otf\" installed"
        fi
    fi

    if [ -e ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
        rm -rf ~/.zshrc.bak
        mv ~/.zshrc ~/.zshrc.bak
    fi
    ln -fs "$script_dir"/.zshrc ~/.zshrc
    echo ".zshrc installed"

    local f

    echo -n "Install executables into ~/bin [y/N]? "
    read ans
    if [ "${ans,,}" = "y" ]; then
        if [ ! -e ~/bin ]; then
            mkdir ~/bin
        fi
        for f in bin/*; do
            if [ "$(basename "$f")" = "README"* ] || [ "$(basename "$f")" = "LICENSE"* ]; then
                continue
            fi
            ln -s "$(pwd)/$f" ~/bin
        done
        echo "executables installed to ~/bin"
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

    if [ -L ~/.ideavimrc ]; then
        unlink ~/.ideavimrc
        if [ -e ~/.ideavimrc.bak ]; then
            mv ~/.ideavimrc.bak ~/.ideavimrc
        fi
        echo ".ideavimrc uninstalled"
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

    if [ -L ~/.tmux.darwin.conf ]; then
        unlink ~/.tmux.darwin.conf
        if [ -e ~/.tmux.darwin.conf.bak ]; then
            mv ~/.tmux.darwin.conf.bak ~/.tmux.darwin.conf
        fi
        echo ".tmux.darwin.conf uninstalled"
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

    if [ -L ~/.dircolors ]; then
        unlink ~/.dircolors
        echo "dircolorsdb uninstalled"
    fi

    if [[ "${OSTYPE,,}" == linux* ]]; then
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

    if [ -L ~/.zshrc ]; then
        unlink ~/.zshrc
        if [ -e ~/.zshrc.bak ]; then
            mv ~/.zshrc.bak ~/.zshrc
        fi
        echo ".zshrc uninstalled"
    fi

    local f

    if [ -d ~/bin ]; then
        for f in ~/bin/*; do
            if [ ! -L "$f" ]; then
                continue
            fi
            if [[ "$(readlink "$f")" != "$script_dir/bin/"* ]]; then
                continue
            fi
            unlink "$f"
        done
        echo "executables uninstalled from ~/bin"
    fi

    INFO "uninstallation completed"
}

cd "$script_dir"

if [[ $install ]]; then
    uninstall
    install
elif [[ $uninstall ]]; then
    uninstall
fi
