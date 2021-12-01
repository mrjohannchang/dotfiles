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

    if [ -e "$HOME/.bash_completion.d" ] && [ ! -L "$HOME/.bash_completion.d" ]; then
        rm -rf "$HOME/.bash_completion.d.bak"
        mv "$HOME/.bash_completion.d" "$HOME/.bash_completion.d.bak"
    fi
    ln -fs "$script_dir"/home/.bash_completion.d "$HOME/.bash_completion.d"
    echo ".bash_completion.d installed"

    if [ -e "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
        rm -rf "$HOME/.bashrc.bak"
        mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
    fi
    ln -fs "$script_dir"/home/.bashrc "$HOME/.bashrc"
    echo ".bashrc installed"

    if [ -e "$HOME/.ideavimrc" ] && [ ! -L "$HOME/.ideavimrc" ]; then
        rm -rf "$HOME/.ideavimrc.bak"
        mv "$HOME/.ideavimrc" "$HOME/.ideavimrc.bak"
    fi
    ln -fs "$script_dir"/home/.ideavimrc "$HOME/.ideavimrc"
    echo ".ideavimrc installed"

    if [ -e "$HOME/.pentadactylrc" ] && [ ! -L "$HOME/.pentadactylrc" ]; then
        rm -rf "$HOME/.pentadactylrc.bak"
        mv "$HOME/.pentadactylrc" "$HOME/.pentadactylrc.bak"
    fi
    ln -fs "$script_dir"/home/.pentadactylrc "$HOME/.pentadactylrc"
    echo ".pentadactylrc installed"

    if [ -e "$HOME/.profile" ] && [ ! -L "$HOME/.profile" ]; then
        rm -rf "$HOME/.profile.bak"
        mv "$HOME/.profile" "$HOME/.profile.bak"
    fi
    ln -fs "$script_dir"/home/.profile "$HOME/.profile"
    echo ".profile installed"

    if [ -e "$HOME/.tmux" ] && [ ! -L "$HOME/.tmux" ]; then
        rm -rf "$HOME/.tmux.bak"
        mv "$HOME/.tmux" "$HOME/.tmux.bak"
    fi
    ln -fs "$script_dir"/home/.tmux "$HOME/.tmux"
    echo ".tmux installed"

    if [ -e "$HOME/.tmux.conf" ] && [ ! -L "$HOME/.tmux.conf" ]; then
        rm -rf "$HOME/.tmux.conf.bak"
        mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
    fi
    ln -fs "$script_dir"/home/.tmux.conf "$HOME/.tmux.conf"
    if [[ "${OSTYPE,,}" == darwin* ]]; then
      if [ -e "$HOME/.tmux.darwin.conf" ] && [ ! -L "$HOME/.tmux.darwin.conf" ]; then
          rm -rf "$HOME/.tmux.darwin.conf.bak"
          mv "$HOME/.tmux.darwin.conf" "$HOME/.tmux.darwin.conf.bak"
      fi
      ln -fs "$script_dir"/home/.tmux.darwin.conf "$HOME/.tmux.darwin.conf"
    fi
    echo ".tmux.conf installed"

    if [ -e "$HOME/.vim" ] && [ ! -L "$HOME/.vim" ]; then
        rm -rf "$HOME/.vim.bak"
        mv "$HOME/.vim" "$HOME/.vim.bak"
    fi
    ln -fs "$script_dir"/home/.vim "$HOME/.vim"
    echo ".vim installed"

    if [ -e "$HOME/.vimrc" ] && [ ! -L "$HOME/.vimrc" ]; then
        rm -rf "$HOME/.vimrc.bak"
        mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
    fi
    ln -fs "$script_dir"/home/.vimrc "$HOME/.vimrc"
    echo ".vimrc installed"

    if [ -e "$HOME/.vimperatorrc" ] && [ ! -L "$HOME/.vimperatorrc" ]; then
        rm -rf "$HOME/.vimperatorrc.bak"
        mv "$HOME/.vimperatorrc" "$HOME/.vimperatorrc.bak"
    fi
    ln -fs "$script_dir"/home/.vimperatorrc "$HOME/.vimperatorrc"
    echo ".vimperatorrc installed"

    if [ ! -e "$HOME/.config" ]; then
        mkdir "$HOME/.config"
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
        if [ -e "$HOME/.dircolors" ] && [ ! -L "$HOME/.dircolors" ]; then
            rm -rf "$HOME/.dircolors.bak"
            mv "$HOME/.dircolors" "$HOME/.dircolors.bak"
        fi
        ln -fs "$script_dir"/home/.dircolors "$HOME/.dircolors"
        echo ".dircolorsdb installed"
    fi

    if [[ "${OSTYPE,,}" == linux* ]]; then
        if [ ! -d "$HOME/.local/share/fonts" ]; then
            mkdir -p "$HOME/.local/share/fonts"
        fi

        if [ ! -d "$HOME/.config/fontconfig/conf.d" ]; then
            mkdir -p "$HOME/.config/fontconfig/conf.d"
        fi

        ln -fs "$script_dir"/home/.local/share/fonts/PowerlineSymbols.otf "$HOME/.local/share/fonts"
        ln -fs "$script_dir"/home/.config/fontconfig/conf.d/10-powerline-symbols.conf "$HOME/.config/fontconfig/conf.d"
        echo "Powerline's font installed"

        ln -fs "$script_dir"/home/.config/fontconfig/conf.d/20-noto-cjk.conf "$HOME/.config/fontconfig/conf.d"
        echo "Noto Sans' fontconfig installed"

        ln -fs "$script_dir"/home/.local/share/fonts/jf-openhuninn-1.1.ttf "$HOME/.local/share/fonts"
        ln -fs "$script_dir"/home/.config/fontconfig/conf.d/30-jf-openhuninn.conf "$HOME/.config/fontconfig/conf.d"
        echo "justfont open 粉圓 installed"
    elif [[ "${OSTYPE,,}" == darwin* ]]; then
        if [ -d "$HOME/Library/Fonts" ]; then
            ln -fs "$script_dir/home/.local/share/fonts/Monaco for Powerline.otf" "$HOME/Library/Fonts"
            echo "font \"Monaco for Powerline.otf\" installed"
        fi
    fi

    if [ -e "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
        rm -rf "$HOME/.zshrc.bak"
        mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    fi
    ln -fs "$script_dir"/home/.zshrc "$HOME/.zshrc"
    echo ".zshrc installed"

    local f

    echo -n "Install custom bin folder into $HOME/bin.d [y/N]? "
    read ans
    if [ "${ans,,}" = "y" ]; then
        if [ ! -e "$HOME/bin.d" ]; then
            mkdir "$HOME/bin.d"
        fi
        ln -fs "$script_dir/home/bin" "$HOME/bin.d/changyuheng"
        echo "custom bin folder installed"
    fi

    INFO "installation completed"
}

uninstall() {
    INFO "begin to uninstall"

    if [ -L "$HOME/.bash_completion.d" ]; then
        unlink "$HOME/.bash_completion.d"
        if [ -e "$HOME/.bash_completion.d.bak" ]; then
            mv "$HOME/.bash_completion.d.bak" "$HOME/.bash_completion.d"
        fi
        echo ".bash_completion.d uninstalled"
    fi

    if [ -L "$HOME/.bashrc" ]; then
        unlink "$HOME/.bashrc"
        if [ -e "$HOME/.bashrc.bak" ]; then
            mv "$HOME/.bashrc.bak" "$HOME/.bashrc"
        fi
        echo ".bashrc uninstalled"
    fi

    if [ -L "$HOME/.ideavimrc" ]; then
        unlink "$HOME/.ideavimrc"
        if [ -e "$HOME/.ideavimrc.bak" ]; then
            mv "$HOME/.ideavimrc.bak" "$HOME/.ideavimrc"
        fi
        echo ".ideavimrc uninstalled"
    fi

    if [ -L "$HOME/.pentadactylrc" ]; then
        unlink "$HOME/.pentadactylrc"
        if [ -e "$HOME/.pentadactylrc.bak" ]; then
            mv "$HOME/.pentadactylrc.bak" "$HOME/.pentadactylrc"
        fi
        echo ".pentadactylrc uninstalled"
    fi

    if [ -L "$HOME/.profile" ]; then
        unlink "$HOME/.profile"
        if [ -e "$HOME/.profile.bak" ]; then
            mv "$HOME/.profile.bak" "$HOME/.profile"
        fi
        echo ".profile uninstalled"
    fi

    if [ -L "$HOME/.tmux" ]; then
        unlink "$HOME/.tmux"
        if [ -e "$HOME/.tmux.bak" ]; then
            mv "$HOME/.tmux.bak" "$HOME/.tmux"
        fi
        echo ".tmux uninstalled"
    fi

    if [ -L "$HOME/.tmux.conf" ]; then
        unlink "$HOME/.tmux.conf"
        if [ -e "$HOME/.tmux.conf.bak" ]; then
            mv "$HOME/.tmux.conf.bak" "$HOME/.tmux.conf"
        fi
        echo ".tmux.conf uninstalled"
    fi

    if [ -L "$HOME/.tmux.darwin.conf" ]; then
        unlink "$HOME/.tmux.darwin.conf"
        if [ -e "$HOME/.tmux.darwin.conf.bak" ]; then
            mv "$HOME/.tmux.darwin.conf.bak" "$HOME/.tmux.darwin.conf"
        fi
        echo ".tmux.darwin.conf uninstalled"
    fi

    if [ -L "$HOME/.vim" ]; then
        unlink "$HOME/.vim"
        if [ -e "$HOME/.vim.bak" ]; then
            mv "$HOME/.vim.bak" "$HOME/.vim"
        fi
        echo ".vim uninstalled"
    fi

    if [ -L "$HOME/.vimrc" ]; then
        unlink "$HOME/.vimrc"
        if [ -e "$HOME/.vimrc.bak" ]; then
            mv "$HOME/.vimrc.bak" "$HOME/.vimrc"
        fi
        echo ".vimrc uninstalled"
    fi

    if [ -L "$HOME/.vimperatorrc" ]; then
        unlink "$HOME/.vimperatorrc"
        if [ -e "$HOME/.vimperatorrc.bak" ]; then
            mv "$HOME/.vimperatorrc.bak" "$HOME/.vimperatorrc"
        fi
        echo ".vimperatorrc uninstalled"
    fi

    if [ -L "$HOME/.dircolors" ]; then
        unlink "$HOME/.dircolors"
        echo "dircolorsdb uninstalled"
    fi

    if [[ "${OSTYPE,,}" == linux* ]]; then
        if [ -L "$HOME/.local/share/fonts/PowerlineSymbols.otf" ] ||
            [ -L "$HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf" ]; then
            if [ -L "$HOME/.local/share/fonts/PowerlineSymbols.otf" ]; then
                unlink "$HOME/.local/share/fonts/PowerlineSymbols.otf"
            fi
            if [ -L "$HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf" ]; then
                unlink "$HOME/.config/fontconfig/conf.d/10-powerline-symbols.conf"
            fi
            echo "Powerline's font uninstalled"
        fi

        if [ -L "$HOME/.config/fontconfig/conf.d/20-noto-cjk.conf" ]; then
            unlink "$HOME/.config/fontconfig/conf.d/20-noto-cjk.conf"
            echo "Noto Sans' fontconfig uninstalled"
        fi

        if [ -L "$HOME/.local/share/fonts/jf-openhuninn-1.1.ttf" ] ||
            [ -L "$HOME/.config/fontconfig/conf.d/30-jf-openhuninn.conf" ]; then
            if [ -L "$HOME/.local/share/fonts/jf-openhuninn-1.1.ttf" ]; then
                unlink "$HOME/.local/share/fonts/jf-openhuninn-1.1.ttf"
            fi
            if [ -L "$HOME/.config/fontconfig/conf.d/30-jf-openhuninn.conf" ]; then
                unlink "$HOME/.config/fontconfig/conf.d/30-jf-openhuninn.conf"
            fi
            echo "justfont open 粉圓 uninstalled"
        fi
    elif [[ "${OSTYPE,,}" == darwin* ]]; then
        if [ -L "$HOME/Library/Fonts/Monaco for Powerline.otf" ]; then
            unlink "$HOME/Library/Fonts/Monaco for Powerline.otf"
            echo "font \"Monaco for Powerline.otf\" uninstalled"
        fi
    fi

    if [ -L "$HOME/.zshrc" ]; then
        unlink "$HOME/.zshrc"
        if [ -e "$HOME/.zshrc.bak" ]; then
            mv "$HOME/.zshrc.bak" "$HOME/.zshrc"
        fi
        echo ".zshrc uninstalled"
    fi

    local f
    local executable_uninstalled

    if [ -L "$HOME/bin.d/changyuheng" ]; then
        unlink "$HOME/bin.d/changyuheng"
        echo "custom bin folder uninstalled"
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
