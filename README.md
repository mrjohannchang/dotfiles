# Dotfiles by changyuheng

## Installation

### OS X

**Prerequisites**

- Xcode and its Command Line Tools
- CMake

**Install**

Run in the shell

```
git submodule update --init --recursive --remote
./os-x-install.sh
```

Open Vim and execute

```
:PlugInstall
```

Open Tmux and press

`C-s I`

### Ubuntu

**Prerequisites**

```sh
sudo apt-get install build-essential cmake python-dev git
```

**Iinstall**

Run in the shell

```sh
git submodule update --init --recursive --remote
./ubuntu-install.sh
```

Open Vim and execute

```
:PlugInstall
```

Open Tmux and press

`C-s I`

## Uninstallation

### OS X

```
./os-x-uninstall.sh
```

### Ubuntu

```sh
./ubuntu-uninstall.sh
```

## License

Except where otherwise noted, all parts of this software is licensed under the
[MIT license](http://opensource.org/licenses/MIT).

© 2015 Chang Yu-heng
