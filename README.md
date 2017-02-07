# Dotfiles by changyuheng

## Prerequisites

### OS X

- Xcode and its Command Line Tools
- CMake
- Homebrew
- Bash
- Python 3
- CMake
- reattach-to-user-namespace

```
brew install go fish tmux bash python3 cmake reattach-to-user-namespace
brew install macvim --with-override-system-vim
```

### Ubuntu

```
sudo apt-get install build-essential cmake python-dev git golang fish tmux vim-gnome
```

### For all

- Fisherman
    ```
    curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
    ```
- nvm
- pyenv
- Python 3

## Installation

1. Run in the shell

    ```
    git submodule update --init --recursive --remote
    ./install.sh
    ```

2. Open Vim and execute `:PlugInstall`

3. Open Tmux and press `C-s I`

## Uninstallation

```
./uninstall.sh
```

## License

Except where otherwise noted, all parts of this software is licensed under the
[MIT license](http://opensource.org/licenses/MIT).

© 2015 Chang Yu-heng
