# Dotfiles by changyuheng

## Prerequisites

### OS X

- Xcode and its Command Line Tools
- Homebrew [link](http://brew.sh/)

```
brew install go fish tmux bash python3 cmake reattach-to-user-namespace
brew install macvim --with-override-system-vim
```

- Set fish to default login shell
    ![](assets/images/macos-default-login-shell.png)

### Ubuntu

```
sudo apt-get install build-essential cmake python-dev git golang fish tmux vim-gnome python3
```

### For all

- Fisherman [link](https://github.com/fisherman/fisherman)
- nvm [link](https://github.com/creationix/nvm)
- pyenv [link](https://github.com/yyuu/pyenv)

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

© 2017 Henry Chang
