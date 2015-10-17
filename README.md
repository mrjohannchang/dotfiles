# Dotfiles by changyuheng

## Prerequisites

### OS X

- Xcode and its Command Line Tools
- CMake

### Ubuntu

```sh
sudo apt-get install build-essential cmake python-dev git
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
