# Dotfiles by changyuheng

## Screenshots

![](screenshots/git.png)
![](screenshots/root.png)
![](screenshots/vim-ctrl-p.png)
![](screenshots/vim.png)

## Prerequisites

- [fzf](https://github.com/junegunn/fzf)
- [nvm](https://github.com/creationix/nvm)
- [pyenv](https://github.com/pyenv/pyenv)
- [zplug](https://github.com/zplug/zplug)

### macOS specific

- [Homebrew](http://brew.sh/)

    ```
    brew install bash
    brew install cmake ctags
    brew install go
    brew install nvm
    brew install pyenv python3
    brew install coreutils fd ripgrep tmux trash
    ```

- Set preferred login shell

    ![](screenshots/macos-default-login-shell.png)

### Ubuntu specific (tested on Ubuntu 20.04 Focal Fossa Desktop)

```
sudo apt install build-essential cmake git golang tmux vim-gtk3 python3 python3-dev curl fd-find ripgrep zsh exuberant-ctags trash-cli
```

## Installation

1. Clone and cd into this repo.

2. Do this in the terminal:
    ```
    git submodule update --init --recursive --remote
    ./install.sh
    ```

3. Open Tmux and press `C-s I`

4. Open Vim and execute `:PlugInstall`

## Uninstallation

```
./uninstall.sh
```
