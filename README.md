![screenshots/zsh-prompt.png](screenshots/zsh-prompt.png)

# changyuheng’s dotfiles

<!-- TOC generated with https://derlin.github.io/bitdowntoc/ -->
- [About](#about)
- [Features](#features)
  * [Programs and Fonts](#programs-and-fonts)
  * [Z Shell (zsh)](#z-shell-zsh)
    + [Z Shell Plugins](#z-shell-plugins)
  * [Neovim (nvim)](#neovim-nvim)
    + [Neovim Plugins](#neovim-plugins)
  * [Tmux](#tmux)
    + [Tmux Plugins](#tmux-plugins)
  * [Supported Virtual Environments](#supported-virtual-environments)
- [Setup](#setup)
  * [Prerequisites](#prerequisites)
    + [Linux (tested on Ubuntu 20.04 Focal Fossa Desktop)](#linux-tested-on-ubuntu-2004-focal-fossa-desktop)
    + [macOS](#macos)
    + [Microsoft Windows (tested on Windows 10)](#microsoft-windows-tested-on-windows-10)
      - [TODO](#todo)
  * [Installation](#installation)
  * [Tweak](#tweak)
    + [Ubuntu](#ubuntu)
      - [Traditional Chinese input methods](#traditional-chinese-input-methods)
  * [Uninstallation](#uninstallation)

## About

* **Cross-platform** - Support [Linux](https://en.wikipedia.org/wiki/Linux), [macOS](https://en.wikipedia.org/wiki/MacOS), and [Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows).
* **Modern** - Prefer:
  * [Z shell (Zsh)](https://en.wikipedia.org/wiki/Z_shell) over [Bourne Again Shell (Bash)](https://en.wikipedia.org/wiki/Bash_(Unix_shell)).
  * [Neovim](https://en.wikipedia.org/wiki/Vim_(text_editor)#Neovim) over [Vi IMproved (Vim)](https://en.wikipedia.org/wiki/Vim_(text_editor)).
  * [ripgrep](https://github.com/BurntSushi/ripgrep) over [grep](https://en.wikipedia.org/wiki/Grep).
  * [fd](https://github.com/sharkdp/fd) over [find](https://en.wikipedia.org/wiki/Find_(Unix)).

* **Lightweight** - Balanced between performance and numbers of features.
* **Pure** - Only putting symbolic links of config files to the system. No modification to existing system files.
* **Configurable**
  * Support both light and dark background. Further reading: [Is Dark Mode Better for Your Eyes?](https://rxoptical.com/eye-health/is-dark-mode-better-for-your-eyes/)
  * Interactive installation process.
* **Compliant** - Follow standards of [XDG Base Directory](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) and [Unix](https://en.wikipedia.org/wiki/Unix) convention.
* **Minimal Pollution** - Prefer adding config files instead of replacing them when it's possible.
* **Removable** - Has a built-in uninstaller.

## Features

### Programs and Fonts

1. [fd](https://github.com/sharkdp/fd)
2. [jf open 粉圓](https://github.com/justfont/open-huninn-font)
3. [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
4. [ripgrep](https://github.com/BurntSushi/ripgrep)
5. [zoxide](https://github.com/ajeetdsouza/zoxide)

### Z Shell (zsh)

#### Z Shell Plugins

1. [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)
2. [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
   1. [lib/completion](https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh)
   2. [lib/history](https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh)
   3. [lib/key-bindings](https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh)
   4. [plugins/docker-compose](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose)
   5. [plugins/nvm](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm)
   6. [plugins/pyenv](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/pyenv)
   7. [plugins/rvm](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/rvm)
3. [Znap](https://github.com/marlonrichert/zsh-snap)
4. [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
5. [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions)

### Neovim (nvim)

1. Reselect visual block after indent/outdent.
2. Enable moving up and down with j and k in wrapped lines.
3. Clear the search highlight with `<LEADER>/`.
4. Saving files as root with `w!!`.
5. Better command-line editing.
   1. `CTRL + j` and `CTRL + k` move to lines that have identical prefixes.
   2. `CTRL + a` and `CTRL + e` move to the beginning and the end of the line.
6. Toggle paste mode with `<F2>`.
   1. Leave paste mode on leaving insert mode
7. Telescope
   1. Find: `<LEADER>ff`
   2. Grep: `<LEADER>fg`
   3. Buffers: `<LEADER>fb`
   4. Help tags: `<LEADER>fh`

#### Neovim Plugins

1. [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
2. [paq](https://github.com/savq/paq-nvim)
3. [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

### Tmux

1. Tmux prefix key: `CTRL + s`.
2. Switch to the last window: `CTRL + s`.
3. Send prefix: `CTRL + a`.
4. Selection:
   1. Select: `v`
   2. Block select: `V`
5. Tmux Resurrect key bindings:
   1. Save: `s`
   2. Restore: `r`

#### Tmux Plugins

1. [tmux-colors-solarized](https://github.com/seebi/tmux-colors-solarized)
2. [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)
3. [tmux-open](https://github.com/tmux-plugins/tmux-open)
4. [tmux-pain-control](https://github.com/tmux-plugins/tmux-pain-control)
5. [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
6. [tmux-sidebar](https://github.com/tmux-plugins/tmux-sidebar)
7. [tmux-yank](https://github.com/tmux-plugins/tmux-yank)
8. [Tmux Plugin Manager (tpm)](https://github.com/tmux-plugins/tpm)

### Supported Virtual Environments

1. [Node Version Manager - nvm](https://github.com/nvm-sh/nvm)
2. [Simple Python version management: pyenv](https://github.com/pyenv/pyenv)
3. [Ruby enVironment Manager (RVM)](https://github.com/rvm/rvm)

## Setup

### Prerequisites

<details>
  <summary>Click to expand</summary>

#### Linux (tested on Ubuntu 20.04 Focal Fossa Desktop)

1. Install necessary packages.

   Note: zoxide only exists in 21.04+

   ```
   sudo apt install build-essential cmake git golang tmux python3 python3-dev curl fd-find ripgrep zsh exuberant-ctags trash-cli fzf xsel zoxide
   ```

2. Change default shell to [Zsh](https://www.zsh.org/).

   ```
   chsh zsh
   ```

3. Install [flatpak](https://flatpak.org/).

   ```
   sudo apt install flatpak
   ```

4. Install [Neovim](https://neovim.io/).

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

7. Install [Nerd Font](https://www.nerdfonts.com/) - [Hack](https://sourcefoundry.org/hack/) by following the [installation instruction](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack#linux).

8. Config the terminal to use the font Nerd Font - Hack that's installed in #1.

#### macOS

1. Install [Homebrew](http://brew.sh/).

   ```
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Install necessary packages.

   ```
   brew install bash zsh cmake ctags go nvm pyenv python3 coreutils fd ripgrep tmux trash fzf neovim gotags zoxide

   brew tap homebrew/cask-fonts
   brew install font-hack-nerd-font
   ```

3. Change default shell to [Zsh](https://www.zsh.org/).

   1. Add the result of `which zsh` to `/etc/shells`.
   2. ```
      chsh -s $(which zsh)
      ```

4. Config the terminal to use the font Nerd Font - Hack that's installed in #2.

#### Microsoft Windows (tested on Windows 10)

1. [Activate Developer Mode](https://docs.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development) from: Start > Settings > Update & Security > For developers > Developer Mode

   * [Symlinks support](https://blogs.windows.com/windowsdeveloper/2016/12/02/symlinks-windows-10/) for non-administrator users will be enabled automatically. If you still have issues, please turn on the `Create symbolic links` permission manually from Start > Local Security Policy > Security Settings > Local Policies > User Rights Assignment > Create symbolic links

2. Enable the [long file path support](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=cmd) from: Start > Local Group Policy Editor > Local Computer Policy > Computer Configuration > Administrative Templates > System > Filesystem > Enable Win32 long paths

3. Install [Chocolatey](https://chocolatey.org/). Execute the following command in a [PowerShell](https://en.wikipedia.org/wiki/PowerShell) Session as administrator.

   ```
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

4. Follow the official [doc](https://www.msys2.org/#installation) to download and install [MSYS2](https://en.wikipedia.org/wiki/MinGW#Fork) (msys2-x86_64).

   * If the installation is stuck at `Updating trust database`, just cancel the installation process and launch the installer again.

5. Install [Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/) from Windows Store.

   * Disable copy & paste mappings to `ctrl + c` and `ctrl + v`. It can be deleted by editing the `settings.json`, which can be opened from settings.

   * Make `ctrl + tab` switching tabs in the MRU order.

   * Make Windows Terminal support MSYS2's shell by adding the following config to `settings.json`:

     ```
     "profiles": {
       "list":
       [
         // ...
            {
                "bellStyle": "none",
                "commandline": "C:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64 -use-full-path",
                "guid": "{7e049a6e-6aea-4e66-9bd3-a4bd49a49bab}",
                "icon": "C:/msys64/mingw64.ico",
                "name": "MINGW64 / MSYS2 - Zsh",
                "startingDirectory": "C:/msys64/home/%USERNAME%"
            },
         // ...
       ]
     }
     ```

   * [Make MSYS2 read Windows environment variables](https://stackoverflow.com/a/50992294/1592410).

     1. Add option `-use-full-path` to the `commandline` in MSYS2 profile in Windows Terminal `settings.json`. (It's already done in the previous step.)
     2. If the above parameter doesn't take effect, uncomment `set MSYS2_PATH_TYPE=inherit` in `C:\msys64\msys2_shell.cmd` and `MSYS2_PATH_TYPE=inherit` in `C:\msys64\mingw64.ini`.

6. Enable the symbolic link support in MSYS2. Uncomment the following line in `C:\msys64\msys2_shell.cmd`

   ```
   set MSYS=winsymlinks:nativestrict
   ```
 
   and the following line in `C:\msys64\mingw64.ini`.
 
   ```
   MSYS=winsymlinks:nativestrict
   ```

7. Fix chocolatey not able to read the `tmp` folder on MSYS2 issue by commenting out the following lines in `/etc/profile`.

   ```
   unset TMP TEMP
   tmp=$(exec cygpath -w "$ORIGINAL_TMP" 2> /dev/null)
   temp=$(exec cygpath -w "$ORIGINAL_TEMP" 2> /dev/null)
   TMP="/tmp"
   TEMP="/tmp"
   ```

8. Install necessary packages with chocolatey in an elevated terminal.

   ```
   choco install neovim nerdfont-hack fd ripgrep universal-ctags fzf zoxide
   ```

9. Config the terminal to use the font Nerd Font - Hack.

10. Install [Git for Windows](https://github.com/git-for-windows/git/releases) with the following features enabled.

    * Git LFS
    * File system caching
    * Symbolic links
    * Built-in file system monitor

11. Install [Zsh](https://www.zsh.org/) on MSYS2's shell. Other commands in the following steps should all be executed in MSYS2's shell.

    ```
    pacman -S zsh
    ```

12. [Change default shell](https://superuser.com/questions/961699/change-default-shell-on-msys2) of MSYS2 to [Zsh](https://www.zsh.org/) by adding `-shell zsh` to the cmdline of MSYS2 in Windows Terminal `settings.json`.

    ```
    "commandline": "C:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64 -use-full-path -shell zsh"
    ```

13. Make `%TMEP%` be mounted at `/tmp` by adding the following contents to `/etc/fstab`.

    ```
    none /tmp usertemp binary,posix=0,noacl 0 0
    ```

14. Set Windows `%USERPROFILE%` folder (`C:\Users\<user name>`) as the `$HOME` folder by adding the following contents to `/etc/fstab`. Ref: [How to change HOME directory and start directory on MSYS2?](https://stackoverflow.com/a/66946901/1592410).

    ```
    ##################################################################
    # Canonicalize the two home directories by mounting the windows  #
    # user home with the same path mapping as unix.                  #
    ##################################################################
    C:/Users /home ntfs binary,posix=0,noacl,user 0 0
    ```

15. [Make MSYS2 shell compatible with Git for Windows](https://github.com/git-for-windows/git/wiki/Install-inside-MSYS2-proper).

    1. Edit `/etc/pacman.conf` with `nvim` and add the Git for Windows package repositories above any others (i.e. just before `[mingw32]` on line #71 as of this writing):

       ```
       [git-for-windows]
       Server = https://wingit.blob.core.windows.net/x86-64

       [git-for-windows-mingw32]
       Server = https://wingit.blob.core.windows.net/i686
       ```

    2. Authorize the signing key with:

       ```
       curl -L https://raw.githubusercontent.com/git-for-windows/build-extra/HEAD/git-for-windows-keyring/git-for-windows.gpg |
       pacman-key --add - &&
       pacman-key --lsign-key E8325679DFFF09668AD8D7B67115A57376871B1C &&
       pacman-key --lsign-key 3B6D86A1BA7701CD0F23AED888138B9E1A9F3986
       ```

    3. Then synchronize with new repositories with

       ```
       pacman -Syyuu
       ```

       This installs a new `msys2-runtime` and therefore will ask you to terminate all MSYS2 processes. Save what you need from other open MSYS2 shells and programs, exit them and confirm the Pacman prompt. Double-check Task Manager and kill `pacman.exe` if it's still running after the window is closed. Start a new MSYS2 terminal.

    4. Then synchronize *again* to install the rest:

       ```
       pacman -Suu
       ```

       It might happen that some packages are downgraded, this is expected.

16. Borrow useful shell input config from Git for Windows.

    ```
    ln -s "/c/Program Files/Git/etc/inputrc" /etc
    ```

17. Disable the terminal bell from `/etc/inputrc` by changing the bell-style from `visual` to `none`. Ref: [Disable beep in WSL terminal on Windows 10](https://stackoverflow.com/questions/36724209/disable-beep-in-wsl-terminal-on-windows-10)

    ```
    set bell-style none
    ```

18. Install necessary packages with pacman.

    ```
    pacman -S man
    ```

##### TODO

1. pyenv
2. nvm
3. tmux

</details>

### Installation

1. `git clone` this repo in `$HOME` and `cd` into it.

   ```
   cd $HOME
   git clone --branch main https://github.com/changyuheng/dotfiles.git
   ```

2. [**Windows Only**] Enable case sensitive support from PowerShell.

   ```
   # Execute the following lines in PowerShell
   cd dotfiles
   fsutil.exe file SetCaseSensitiveInfo . enable
   ```

3. Clone sub-modules.

   ```
   git submodule update --init --recursive --remote
   ```

4. Install.

   ```
   ./install.sh
   ```

5. Execute `tmux` and press `C-s I` to install plugins of tmux.

6. Execute `nvim` and then `:PaqInstall` to install plugins of Neovim.

### Tweak

<details>
  <summary>Click to expand</summary>

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

    a. ```
       sudo apt install fcitx-chewing fcitx-table-boshiamy
       ```
    b. Choose `fcitx` as the keyboard input method system in `gnome-language-selector`.
    c. Remove keyboard layouts if there are more than 1 from Input Source in `gnome-control-center` > Region & Language.
    d. Remove the hotkey for switching input source in `gnome-control-center` > Keyboard Shortcuts > Typing.
    e. Replace the hotkey for Trigger Input Method to Super + Space in `fcitx-configtool` > Global Config > Hotkey > Trigger Input Method.

</details>

### Uninstallation

```
cd ~/dotfiles
./uninstall.sh
cd ..
rm -rf dotfiles
```
