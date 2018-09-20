# Dotfiles by changyuheng

## Screenshots

![](screenshots/git.png)
![](screenshots/root.png)
![](screenshots/vim-ctrl-p.png)
![](screenshots/vim.png)

## Prerequisites

### macOS

- Xcode and its Command Line Tools
- [Homebrew](http://brew.sh/)

```
brew install coreutils go fish tmux bash python3 cmake \
  reattach-to-user-namespace the_silver_searcher fzf ctags
brew install macvim --with-override-system-vim
```

- Set preferred login shell
    ![](assets/images/macos-default-login-shell.png)

### Ubuntu

```
sudo apt-get install build-essential cmake python-dev git golang fish tmux \
  vim-gnome python3 python3-dev curl silversearcher-ag zsh exuberant-ctags
```

- [fzf](https://github.com/junegunn/fzf)

### For all

- [nvm](https://github.com/creationix/nvm)
- [pyenv](https://github.com/pyenv/pyenv)

#### Optional
- [fisherman](https://fisherman.github.io/)
- [zplug](https://zplug.sh/)

## Installation

1. Run in the shell

    ```
    cd $HOME
    git clone git@github.com:changyuheng/dotfiles.git
    cd dotfiles
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
