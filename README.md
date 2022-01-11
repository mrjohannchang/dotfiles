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
  * [Optional Tweak](#optional-tweak)
    + [Ubuntu](#ubuntu)
    + [Windows](#windows)
  * [Uninstallation](#uninstallation)
- [Known Issues](#known-issues)

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
3. Clear the search highlight with `<LEADER>` `/`.
4. Saving files as root with `w!!`.
5. Better command-line editing.
   1. `<CTRL> + j` and `<CTRL> + k` move to lines that have identical prefixes.
   2. `<CTRL> + a` and `<CTRL> + e` move to the beginning and the end of the line.
6. Toggle paste mode with `<F2>`.
   1. Leave paste mode on leaving insert mode
7. Comment.nvim
   * NORMAL mode
     1. `g` `c` `c` - Toggles the current line using linewise comment
     2. `g` `b` `c` - Toggles the current line using blockwise comment
     3. `[count]` `g` `c` `c` - Toggles the number of line given as a prefix-count using linewise
     4. `[count]` `g` `b` `c` - Toggles the number of line given as a prefix-count using blockwise
     5. `g` `c` `[count]` `{motion}` - (Op-pending) Toggles the region using linewise comment
     6. `g` `b` `[count]` `{motion}` - (Op-pending) Toggles the region using linewise comment
     7. `g` `c` `o` - Insert comment to the next line and enters INSERT mode
     8. `g` `c` `O` - Insert comment to the previous line and enters INSERT mode
     9. `g` `c` `A` - Insert comment to end of the current line and enters INSERT mode
   * VISUAL mode
     1. `g` `c` - Toggles the region using linewise comment
     2. `g` `b` - Toggles the region using blockwise comment
8. Telescope
   1. Find: `<LEADER>` `f` `f`
   2. Grep: `<LEADER>` `f` `g`
   3. Buffers: `<LEADER>` `f` `b`
   4. Help tags: `<LEADER>` `f` `h`

#### Neovim Plugins

1. [Comment.nvim](https://github.com/numToStr/Comment.nvim)
2. [coq_nvim](https://github.com/ms-jpq/coq_nvim)
3. [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
4. [packer.nvim](https://github.com/wbthomason/packer.nvim)
5. [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

### Tmux

1. Tmux prefix key: `<CTRL> + s`.
2. Switch to the last window: `<CTRL> + s`.
3. Send prefix: `<CTRL> + a`.
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

#### Linux (tested on Ubuntu 20.04 Focal Fossa Desktop)

<details>
  <summary>Click to expand</summary>

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

8. Config the terminal to use the font Hack Nerd Font that's installed in #1.

</details>

#### macOS

<details>
  <summary>Click to expand</summary>

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

4. Config the terminal to use the font Hack Nerd Font that's installed in #2.

</details>

#### Microsoft Windows (tested on Windows 10)

<details>
  <summary>Click to expand</summary>

1. [Activate Developer Mode](https://docs.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development) from: Start > Settings > Update & Security > For developers > Developer Mode. Enabling this feature will enable the symbolic link support.

2. Enable the [long file path support](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=cmd) from: Start > Local Group Policy Editor > Local Computer Policy > Computer Configuration > Administrative Templates > System > Filesystem > Enable Win32 long paths

3. Follow the official [doc](https://www.msys2.org/#installation) to download and install [MSYS2](https://en.wikipedia.org/wiki/MinGW#Fork) (msys2-x86_64).

   1. Enable the symbolic link support in MSYS2 by uncommenting the following line in `C:\msys64\msys2_shell.cmd`

      ```
      rem set MSYS=winsymlinks:nativestrict
      ```

      and the following line in `C:\msys64\mingw64.ini`.

      ```
      #MSYS=winsymlinks:nativestrict
      ```

   2. Uncomment `rem set MSYS2_PATH_TYPE=inherit` in `C:\msys64\msys2_shell.cmd` and `#MSYS2_PATH_TYPE=inherit` in `C:\msys64\mingw64.ini`.

   3. Make `%TMEP%` mounted at `/tmp` by adding the following contents to `C:\msys64\etc\fstab`.

      ```
      none /tmp usertemp binary,posix=0,noacl 0 0
      ```

   4. Set Windows `%USERPROFILE%` folder (`C:\Users\<user name>`) as the `$HOME` folder by adding the following contents to `C:\msys64\etc\fstab`. Ref: [How to change HOME directory and start directory on MSYS2?](https://stackoverflow.com/a/66946901/1592410).

      ```
      ##################################################################
      # Canonicalize the two home directories by mounting the windows  #
      # user home with the same path mapping as unix.                  #
      ##################################################################
      C:/Users /home ntfs binary,posix=0,noacl,user 0 0
      ```

   5. [Install Git for Windows](https://github.com/git-for-windows/git/wiki/Install-inside-MSYS2-proper) via MSYS2.

      1. Add the Git for Windows package repositories above any others (i.e. just before `[mingw32]` on line #68 as of this writing) to `C:\msys64\etc\pacman.conf`:

         ```
         [git-for-windows]
         Server = https://wingit.blob.core.windows.net/x86-64
         ```

      2. Open `MSYS2 MinGW x64`.

      3. Authorize the signing key with:

         ```
         curl -L https://raw.githubusercontent.com/git-for-windows/build-extra/HEAD/git-for-windows-keyring/git-for-windows.gpg |
         pacman-key --add - &&
         pacman-key --lsign-key E8325679DFFF09668AD8D7B67115A57376871B1C &&
         pacman-key --lsign-key 3B6D86A1BA7701CD0F23AED888138B9E1A9F3986
         ```

      4. Then synchronize with new repositories with

         ```
         pacman -Syyuu
         ```

         This installs a new `msys2-runtime` and therefore will ask you to terminate all MSYS2 processes. Save what you need from other open MSYS2 shells and programs, exit them and confirm the Pacman prompt. Double-check Task Manager and kill `pacman.exe` if it's still running after the window is closed. Start a new MSYS2 terminal.

      5. Then synchronize *again* to install the rest:

         ```
         pacman -Suu
         ```

         It might happen that some packages are downgraded, this is expected.

      6. And finally install the packages containing Git, its documentation and some extra things:

         ```
         pacman -S mingw-w64-x86_64-{git,git-doc-html,git-doc-man} git-extra
         ```

   6. Install necessary packages in `MSYS2 MinGW x64`.

      ```
      pacman -Sy mingw-w64-x86_64-connect man tmux zsh
      ```

4. Install [Scoop](https://scoop.sh/). Execute the following commands in a [PowerShell](https://en.wikipedia.org/wiki/PowerShell) Session.

   ```
   Set-ExecutionPolicy RemoteSigned -scope CurrentUser
   Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
   ```

   * Install necessary packages via Scoop in `MSYS2 MinGW x64`.

     ```
     scoop bucket add extras
     scoop bucket add nerd-fonts
     scoop install vcredist2015 neovim Hack-NF fd ripgrep universal-ctags fzf zoxide
     ```

5. Install [Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/) from Windows Store. Configs:

   1. Disable copy & paste mappings to `<CTRL> + c` and `<CTRL> + v` by commenting out related config in `settings.json` which can be opened from settings.

      ```
          "actions": 
          [
              ...
              {
                  "command":
                  {
                      "action": "copy",
                      "singleLine": false
                  },
                  "keys": "ctrl+c"
              },
              {
                  "command": "paste",
                  "keys": "ctrl+v"
              },
              ...
          ],
      ```

   2. Prevent from window being closed when pressing `<CTRL> + <SHIFT> + w` by add the following content to `settings.json`.

      ```
          "actions":
          [
              ...
              {
                  "command": null,
                  "keys": "ctrl+shift+w"
              },
              ...
          ],
      ```

   3. Resolve the key mapping conflict of `<CTRL> + <SHIFT> + 6` in Neovim by add the following content to `settings.json`.

      ```
          "actions":
          [
              ...
              {
                  "command" : null,
                  "keys": "ctrl+shift+6"
              },
              ...
          ],
      ```

   4. Make Windows Terminal support MSYS2's shell by adding the following config to `settings.json`:

      ```
          "profiles": {
              "list":
              [
                  // ...
                  {
                      "bellStyle": "none",
                      "commandline": "C:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64 -shell zsh",
                      "guid": "{7e049a6e-6aea-4e66-9bd3-a4bd49a49bab}",
                      "icon": "C:/msys64/mingw64.ico",
                      "name": "MINGW64 / MSYS2 - Zsh",
                      "startingDirectory": "C:/msys64/home/%USERNAME%"
                  },
                  // ...
              ]
          }
      ```

   5. Config the terminal to use the font Hack NF.

6. Install **official** [Python3](https://www.python.org/downloads/) with **Add Python <version> to PATH** option checked.

7. Pre-installation

   1. Open a `MINGW64 / MSYS2 - Zsh` tab in `Windows Terminal`.

   2. Select `0` to create an empty `~/.zshrc`

   3. Unset empty `$tmp` and `$temp`

      ```
      unset tmp temp
      ```

   4. Enable symlink support for Git

      ```
      git config --global core.symlinks true
      ```
   5. Text files inside dotfiles need to use `LF` as line endings. Don't let Git convert them to `CRLF` on Windows.

      ```
      git config --global core.autocrlf input
      git config --global core.safecrlf warn
      ```

   6. Open an **elevated** (Run as administrator) **PowerShell** session and execute the following command. After the execution, you may need to restart your computer.

      ```
      Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
      ```

##### TODO

Instructions for installing
1. pyenv
2. nvm
3. tmux

</details>

### Installation

1. `git clone` this repo in `$HOME` and `cd` into it. **Note**: The `dotfiles` folder has to be put at `${HOME}/dotfiles`.

   ```
   cd $HOME
   git clone https://github.com/changyuheng/dotfiles.git
   cd dotfiles
   ```

2. [**Windows Only**][**Optional**] Enable case sensitive support for sub-modules from a **PowerShell** session if this dotfiles is stored on an **NTFS** volume.

   ```
   cd $HOME\dotfiles\3rdparty
   (Get-ChildItem -Recurse -Directory).FullName | ForEach-Object {fsutil.exe file setCaseSensitiveInfo $_ enable}
   ```

3. Clone sub-modules.

   ```
   git submodule update --init --recursive --remote
   ```

4. Install. For **Windows** users, after executing `install.sh`, you'll need to exit the Windows Terminal and open it again before going to the next step.

   ```
   ./install.sh
   ```

5. Execute `tmux` (`script -c tmux /dev/null` on **Windows**) and press `<CTRL> + s` `I` to install plugins of tmux.

6. Execute `nvim` and then `:PackerInstall` to install plugins of Neovim. You may need to execute other commands for installing dependencies of some plugins. Please follow the hints you see in Neovim.

   * You can use `:PackerSync` to update the installed plugins in the future. But please do **NOT** remove `<nvim-config>/site/pack/packer/start/packer.nvim` during syncing.

### Optional Tweak

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

2. Install fcitx to replace iBus.

    a. ```
       sudo apt install fcitx-chewing fcitx-table-boshiamy
       ```
    b. Choose `fcitx` as the keyboard input method system in `gnome-language-selector`.
    c. Remove keyboard layouts if there are more than 1 from Input Source in `gnome-control-center` > Region & Language.
    d. Remove the hotkey for switching input source in `gnome-control-center` > Keyboard Shortcuts > Typing.
    e. Replace the hotkey for Trigger Input Method to Super + Space in `fcitx-configtool` > Global Config > Hotkey > Trigger Input Method.

#### Windows

1. Swap caps lock and left control.

   ```
   Windows Registry Editor Version 5.00

   [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
   "Scancode Map"=hex:00,00,00,00,00,00,00,00,03,00,00,00,1d,00,3a,00,3a,00,1d,00,00,00,00,00

   ; Refs:
   ; https://superuser.com/a/1381836
   ```

2. Make Windows Terminal tab switching order in `MRU`.

</details>

### Uninstallation

```
cd ~/dotfiles
./uninstall.sh
cd ..
rm -rf dotfiles
```

## Known Issues

1. Neovim cannot be launched properly inside Windows tmux or MSYS2. Need to switch back to Vim for these environments. [#6751](https://github.com/neovim/neovim/issues/6751) [#8271](https://github.com/neovim/neovim/pull/8271) [#11112](https://github.com/neovim/neovim/issues/11112)

2. Tmux cannot be launched in Windows Terminal directly. Need to use `script -c tmux /dev/null` as workaround ([source](https://github.com/csdvrx/sixel-tmux)). [#5132](https://github.com/microsoft/terminal/issues/5132)
