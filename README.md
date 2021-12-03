# changyuheng’s dotfiles

## About

![](screenshots/git.png)
![](screenshots/root.png)
![](screenshots/vim-ctrl-p.png)
![](screenshots/vim.png)

* **Cross-platform** - Support [Linux](https://en.wikipedia.org/wiki/Linux), [macOS](https://en.wikipedia.org/wiki/MacOS), and [Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows).
* **Modern** - Choose [Z shell (Zsh)](https://en.wikipedia.org/wiki/Z_shell) over [Bourne Again Shell (Bash)](https://en.wikipedia.org/wiki/Bash_(Unix_shell)), [Neovim](https://en.wikipedia.org/wiki/Vim_(text_editor)#Neovim) over [Vi IMproved (Vim)](https://en.wikipedia.org/wiki/Vim_(text_editor)).
* **Lightweight** - Balanced between performance and numbers of features.
* **Customizable**
  * Support both light and dark background. Further reading: [Is Dark Mode Better for Your Eyes?](https://rxoptical.com/eye-health/is-dark-mode-better-for-your-eyes/)
  * Interactive installation process.
* **Canonical** - Follow standards of [XDG Base Directory](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) and [Unix](https://en.wikipedia.org/wiki/Unix) convention.
* **Uninstallable** - Has built-in uninstaller.

## Feature

WIP.

## Installation

### Prerequisites

#### Linux (tested on Ubuntu 20.04 Focal Fossa Desktop)

1. Install necessary packages.

   ```
   sudo apt install build-essential cmake git golang tmux python3 python3-dev curl fd-find ripgrep zsh exuberant-ctags trash-cli fzf fonts-hack-ttf xsel
   ```

2. Change default shell to [Zsh](https://www.zsh.org/).

   ```
   chsh zsh
   ```

3. Install [flatpak](https://flatpak.org/).

   ```
   sudo apt install flatpak
   ```

3. Install [Neovim](https://neovim.io/).

   ```
   flatpak install flathub io.neovim.nvim
   ```

5. Install [Node Version Manager (nvm)](https://github.com/nvm-sh/nvm).

   ```
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
   ```

6. Install [pyenv](https://github.com/pyenv/pyenv).

   ```
   curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
   ```

7. Install [Nerd Font](https://www.nerdfonts.com/) - Hack.

   ```
   mkdir -p ~/.local/share/fonts
   curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
   fc-cache -fv
   ```

7. Config the terminal to use font [Hack](https://sourcefoundry.org/hack/) that we installed on #1.

#### macOS

1. Install [Homebrew](http://brew.sh/).

   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Install necessary packages.

   ```
   brew install bash zsh cmake ctags go nvm pyenv python3 coreutils fd ripgrep tmux trash fzf vim gotags
   
   brew tap homebrew/cask-fonts
   brew install font-hack
   brew install font-hack-nerd-font
   ```

3. Change default shell to [Zsh](https://www.zsh.org/).

   ```
   chsh -s /bin/zsh
   ```

4. Config the terminal to use font [Hack](https://sourcefoundry.org/hack/) that we installed on #2.

#### Microsoft Windows (tested on Windows 10)

1. Install [Chocolatey](https://chocolatey.org/). Execute the following command in a [PowerShell](https://en.wikipedia.org/wiki/PowerShell) Session as administrator.

   ```
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

2. Install [Hack](https://github.com/source-foundry/Hack) and [Nerd Font](https://www.nerdfonts.com/) - Hack.

### Installation

1. `git clone` and `cd` into this repo.

2. Install the configurations:
    ```
    git submodule update --init --recursive --remote
    ./install.sh
    ```

3. Install [zplug](https://github.com/zplug/zplug) with:

    ```
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    ```

4. Open a new zsh shell to install the plugins of `zplug`.

5. Execute `tmux` and press `C-s I` to install the plugins of it.

6. Execute `vim` and then `:PlugInstall` to install the plugins of it.

### Uninstallation

```
./uninstall.sh
```

### Tweak

#### Ubuntu

1. Key remapping for REALFORCE for Mac:

    a. Config udev:
    ```
    sudo cp ubuntu/etc/udev/rules.d/1000-key-remapping-for-realforce-for-mac.rules /etc/udev/rules.d
    sudo udevadm control --reload
    ```
    b. In `Startup Applications Preferences`, add an item that executes "$HOME/dotfiles/scripts/ubuntu/swap-option-and-command-for-realforce-for-mac.sh"

##### Traditional Chinese input methods

1. Install fcitx to replace iBus.

    a.
    ```
    sudo apt install fcitx-chewing fcitx-table-boshiamy
    ```
    b. Choose `fcitx` as the keyboard input method system in `gnome-language-selector`.
    c. Remove keyboard layouts if there are more than 1 from Input Source in `gnome-control-center` > Region & Language.
    d. Remove the hotkey for switching input source in `gnome-control-center` > Keyboard Shortcuts > Typing.
    e. Replace the hotkey for Trigger Input Method to Super + Space in `fcitx-configtool` > Global Config > Hotkey > Trigger Input Method.
