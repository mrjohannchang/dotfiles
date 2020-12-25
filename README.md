# Dotfiles by changyuheng

## Screenshots

![](screenshots/git.png)
![](screenshots/root.png)
![](screenshots/vim-ctrl-p.png)
![](screenshots/vim.png)

## Prerequisites

### macOS

- [Homebrew](http://brew.sh/)

    ```
    brew install bash
    brew install cmake ctags
    brew install go
    brew install nvm
    brew install pyenv python3
    brew install coreutils fd ripgrep tmux trash fzf
    ```

- Set the preferred login shell.

    ![](screenshots/macos-default-login-shell.png)

### Ubuntu (tested on Ubuntu 20.04 Focal Fossa Desktop)

- Install necessary programs.

```
sudo apt install build-essential cmake git golang tmux vim-gtk3 python3 python3-dev curl fd-find ripgrep zsh exuberant-ctags trash-cli fzf
```

- Set the preferred login shell by `chsh`.

## Installation

1. `git clone` and `cd` into this repo.

2. Do this in the terminal:
    ```
    git submodule update --init --recursive --remote
    ./install.sh
    ```

3. Install [nvm](https://github.com/creationix/nvm), [pyenv](https://github.com/pyenv/pyenv), [zplug](https://github.com/zplug/zplug) by following their manuals.

4. Open Tmux and press `C-s I`.

5. Open Vim and execute `:PlugInstall`.

## Uninstallation

```
./uninstall.sh
```

## Tweak


### Ubuntu

1. Key remapping for REALFORCE for Mac:

    a. Config udev:
    ```
    sudo cp ubuntu/etc/udev/rules.d/1000-key-remapping-for-realforce-for-mac.rules /etc/udev/rules.d
    sudo udevadm control --reload
    ```
    b. In `Startup Applications Preferences`, add an item that executes "$HOME/dotfiles/scripts/ubuntu/swap-option-and-command-for-realforce-for-mac.sh"
