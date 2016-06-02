# Dotfiles by changyuheng

## Prerequisites

### Optional

```sh
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
```

### OS X

- Xcode and its Command Line Tools
- CMake
- Homebrew

```sh
brew install go fish
```

### Ubuntu

```sh
sudo apt-get install build-essential cmake python-dev git golang fish
```

## Installation

1. Run in the shell

    ```sh
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
