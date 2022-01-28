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
  * [Installation](#installation)
  * [Optional Tweak](#optional-tweak)
    + [Ubuntu](#ubuntu)
    + [Windows](#windows)
  * [Uninstallation](#uninstallation)
- [Known Issues](#known-issues)
- [To-Do](#to-do)

## About

* **Cross-platform** - Support [Linux](https://en.wikipedia.org/wiki/Linux), [macOS](https://en.wikipedia.org/wiki/MacOS), and [Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows).
* **Modern** (richer features and better performance but may be less compatible) - Prefer:
  * [Z shell (Zsh)](https://en.wikipedia.org/wiki/Z_shell) over [Bourne Again Shell (Bash)](https://en.wikipedia.org/wiki/Bash_(Unix_shell)).
  * [Neovim](https://en.wikipedia.org/wiki/Vim_(text_editor)#Neovim) over [Vi IMproved (Vim)](https://en.wikipedia.org/wiki/Vim_(text_editor)).
  * [ripgrep](https://github.com/BurntSushi/ripgrep) over [grep](https://en.wikipedia.org/wiki/Grep).
  * [fd](https://github.com/sharkdp/fd) over [find](https://en.wikipedia.org/wiki/Find_(Unix)).
* **Lightweight** - Balanced between performance and numbers of features.
  * Specifically, I don't want to make Neovim an IDE but just a text editor. There are already [JetBrains](https://www.jetbrains.com/) and [VS Code](https://code.visualstudio.com/). So I mainly choose plugins that enhance text editing but not focus on adding semantic support.
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

1. The current setup is blazingly fast.

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

1. The current setup is blazingly fast.
2. Reselect visual block after indent/outdent.
3. Enable moving up and down with j and k in wrapped lines.
4. Clear the search highlight with `<Leader>` `/`.
5. Saving files as root with `w!!`.
6. Better command-line editing.
   1. `<Ctrl> + j` and `<Ctrl> + k` move to lines that have identical prefixes.
   2. `<Ctrl> + a` and `<Ctrl> + e` move to the beginning and the end of the line.
7. Toggle paste mode with `<F2>`.
   1. Leave paste mode on leaving insert mode
8. Comment.nvim
   * NORMAL mode
     1. `g` `c` `c` - Toggles the current line using linewise comment
     2. `g` `b` `c` - Toggles the current line using blockwise comment
     3. `[count]` `g` `c` `c` - Toggles the number of line given as a prefix-count using linewise
     4. `[count]` `g` `b` `c` - Toggles the number of line given as a prefix-count using blockwise
     5. `g` `c` `[count]` `<motion>` - (Op-pending) Toggles the region using linewise comment
     6. `g` `b` `[count]` `<motion>` - (Op-pending) Toggles the region using linewise comment
     7. `g` `c` `o` - Insert comment to the next line and enters INSERT mode
     8. `g` `c` `O` - Insert comment to the previous line and enters INSERT mode
     9. `g` `c` `A` - Insert comment to end of the current line and enters INSERT mode
   * VISUAL mode
     1. `g` `c` - Toggles the region using linewise comment
     2. `g` `b` - Toggles the region using blockwise comment
9. Telescope
   1. Close the telescope window: `q`
   2. Delete the highlighted buffer: `d` `d`
   3. Find: `<Leader>` `f` `f`
   4. Grep: `<Leader>` `f` `g`
   5. Buffers: `<Leader>` `f` `b`
   6. Help tags: `<Leader>` `f` `h`
10. surround.vim
    1. `y` `s` `<motion>` `<desired>` - Add desired surround around text defined by `<motion>`
    2. `d` `s` `<existing>` - Delete `<existing>` surround
    3. `c` `s` `<existing>` `<desired>` - Change `<existing>` surround to `<desired>`
    4. `S` `<desired>` - Surround when in visual modes (surrounds full selection)

#### Neovim Plugins

1. [Comment.nvim](https://github.com/numToStr/Comment.nvim)
2. [coq_nvim](https://github.com/ms-jpq/coq_nvim)
3. [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
4. [nvim-solarized-lua](https://github.com/ishan9299/nvim-solarized-lua)
5. [packer.nvim](https://github.com/wbthomason/packer.nvim)
6. [surround.vim](https://github.com/tpope/vim-surround)
7. [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

### Tmux

1. Tmux prefix key: `<Ctrl> + s`.
2. Switch to the last window: `<Ctrl> + s`.
3. Send prefix: `<Ctrl> + a`.
4. Selection:
   1. Select: `v`
   2. Block select: `V`
5. Tmux Resurrect key bindings:
   1. Save: `s`
   2. Restore: `r`
6. Go through installed plugins for more features.

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
   sudo apt install build-essential cmake git git-lfs golang tmux python3 python3-dev curl fd-find ripgrep zsh exuberant-ctags trash-cli fzf xsel zoxide
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
   brew install bash zsh git-lfs cmake ctags go nvm pyenv python3 coreutils fd ripgrep tmux trash fzf neovim gotags zoxide

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

1. `$HOME` (`%USERPROFILE%`) folder **has to** be on an [NTFS](https://en.wikipedia.org/wiki/NTFS) volume.

2. [Activate Developer Mode](https://docs.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development) from: Start > Settings > Update & Security > For developers > Developer Mode. Enabling this feature will enable the symbolic link support.

3. Enable the [long file path support](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation?tabs=cmd) from: Start > Local Group Policy Editor > Local Computer Policy > Computer Configuration > Administrative Templates > System > Filesystem > Enable Win32 long paths

4. Download and install [MSYS2](https://www.msys2.org/#installation), then:

   1. Enable the symbolic link support in MSYS2 by uncommenting the following line in `C:\msys64\msys2_shell.cmd`

      ```
      rem set MSYS=winsymlinks:nativestrict
      ```

      and the following line in `C:\msys64\mingw64.ini`.

      ```
      #MSYS=winsymlinks:nativestrict
      ```

      Note: You can use VS Code to edit those files.

   2. Uncomment `rem set MSYS2_PATH_TYPE=inherit` in `C:\msys64\msys2_shell.cmd` and `#MSYS2_PATH_TYPE=inherit` in `C:\msys64\mingw64.ini` to make MSYS2 inherit environmental variables from Windows.

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

   5. [Install Git for Windows](https://github.com/git-for-windows/git/wiki/Install-inside-MSYS2-proper) via MSYS2 with the following instructions.

      1. Add the Git for Windows package repositories above any others (i.e. just before `[mingw32]` on line #68 as of this writing) to `C:\msys64\etc\pacman.conf`:

         ```
         [git-for-windows]
         Server = https://wingit.blob.core.windows.net/x86-64

         [git-for-windows-mingw32]
         Server = https://wingit.blob.core.windows.net/i686
         ```

      2. Open "MSYS2 MinGW x64" MinTTY (from Windows Start).

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
         pacman -S mingw-w64-x86_64-{git,git-doc-html,git-doc-man,git-lfs} git-extra
         ```

   6. Install necessary packages in `MSYS2 MinGW x64`.

      ```
      pacman -Sy mingw-w64-x86_64-connect man tmux zsh
      ```

5. Install [Scoop](https://scoop.sh/) package manager. Execute the following commands in a **regular** [PowerShell](https://en.wikipedia.org/wiki/PowerShell) Session.

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

6. Install [Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/) from Windows Store. And then do the following configurations:

   1. Disable copy & paste mappings to `<Ctrl> + c` and `<Ctrl> + v` by commenting out related config in `settings.json` which can be opened from the buttom left gear icon of Windows Terminal Settings page. You will still be able to use `<Ctrl> + <Shift> + c` and `<Ctrl> + <Shift> + v` for copying and pasting.

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

   2. Prevent from window being closed when pressing `<Ctrl> + <Shift> + w` by add the following content to `settings.json`.

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

   3. Resolve the key mapping conflict of `<Ctrl> + <Shift> + 6` in Neovim/Vim by adding the following contents to `settings.json`.

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

   5. Set "MINGW64 / MSYS -Zsh" as the default profile from Startup > Default profile.

   6. Config the terminal to use the font "Hack NF" and set your prefered text color scheme in Profiles > MINGW64 / MSYS -Zsh.

7. Install **official** [Python3](https://www.python.org/downloads/) (make sure you download the installer from the official Python website) with **Add Python <version> to PATH** option checked.

8. Pre-installation

   1. Open an **elevated** (Run as administrator) **PowerShell** session and execute the following command. So that you can use `fsutil` in the later process. After the execution, you may need to restart your computer.

      ```
      Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
      ```

   2. Open a "MINGW64 / MSYS2 - Zsh" tab in Windows Terminal.

   3. Select `0` to create an empty `~/.zshrc`

   4. Unset empty `$tmp` and `$temp`.

      ```
      unset tmp temp
      ```

      Note: Empty `$tmp` and `$temp` environment variables are extremely error-prone on Windows. And it's difficult to identify the inroduced errors.

   5. Enable symlink support for Git. This is necessary for the installation of this dotfiles.

      ```
      git config --global core.symlinks true
      ```

   6. Text files inside dotfiles need to use `LF` as line endings. Don't let Git convert line endings to `CRLF` on Windows.

      ```
      git config --global core.autocrlf input
      git config --global core.safecrlf warn
      ```

   7. Remove unnecessary start-up scripts to speed up the shell launching.

      ```
      mv /etc/profile.d/git-prompt.sh{,.bak}
      mv /etc/profile.d/git-sdk.sh{,.bak}
      ```

   8. Go to [Installation](#installation)

</details>

### Installation

1. `git clone` this repo in `$HOME` and `cd` into it. **Note**: The `dotfiles` folder **has to** be put at `${HOME}/dotfiles`. Do not rename `dotfiles` or change the parent folders.

   ```
   cd ~
   git clone https://github.com/changyuheng/dotfiles.git
   cd dotfiles
   ```

2. [**Windows Only**] Enable case sensitive support for sub-modules from a regular **PowerShell** session

   ```
   cd ~\dotfiles\3rdparties
   (Get-ChildItem -Recurse -Directory).FullName | ForEach-Object {fsutil.exe file setCaseSensitiveInfo $_ enable}
   ```

3. Clone sub-modules.

   ```
   git submodule update --init --recursive --remote
   ```

4. Install. For **Windows** users, after executing `install.sh`, you'll need to terminate all the sessions and exit Windows Terminal. Then reopen it for the next step.

   ```
   ./install.sh
   ```

5. Execute `tmux` (the command is `script -c tmux /dev/null` when using **Windows Terminal**) and press `<Ctrl> + s` `I` (uppercase i) to install plugins of tmux. It may take a few minutes. Please expect `tmux` frozen during the installation.

6. Execute `nvim` and then `:PackerInstall` to install plugins of Neovim. You may need to execute other commands for installing dependencies of some plugins. Please follow the hints you see in Neovim.

   * You can use `:PackerSync` to update the installed plugins in the future. But please make sure you do **NOT** remove packer.nvim package manager (`<nvim-config>/site/pack/packer/start/packer.nvim`) during the syncing process.

### Optional Tweak

<details>
  <summary>Click to expand</summary>

#### Ubuntu

1. Install fcitx to replace iBus:

    a. ```
       sudo apt install fcitx-chewing fcitx-table-boshiamy
       ```
    b. Choose `fcitx` as the keyboard input method system in `gnome-language-selector`.
    c. Remove keyboard layouts if there are more than 1 from Input Source in `gnome-control-center` > Region & Language.
    d. Remove the hotkey for switching input source in `gnome-control-center` > Keyboard Shortcuts > Typing.
    e. Replace the hotkey for Trigger Input Method to Super + Space in `fcitx-configtool` > Global Config > Hotkey > Trigger Input Method.

2. Key remapping for REALFORCE for Mac keyboard:

    a. Config udev:

       ```
       sudo cp ubuntu/etc/udev/rules.d/1000-key-remapping-for-realforce-for-mac.rules /etc/udev/rules.d
       sudo udevadm control --reload
       ```

    b. In `Startup Applications Preferences`, add an item that executes "${HOME}/dotfiles/bin/linux/swap-option-and-command-for-realforce-for-mac.sh"

#### Windows

1. Make Windows Terminal tab switching in `MRU` order. Reference: [Open next tab](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/actions#open-next-tab), [Open previous tab](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/actions#open-previous-tab) and [#8025](https://github.com/microsoft/terminal/issues/8025).

2. Swap caps lock and left control.

   ```
   Windows Registry Editor Version 5.00

   [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
   "Scancode Map"=hex:00,00,00,00,00,00,00,00,03,00,00,00,1d,00,3a,00,3a,00,1d,00,00,00,00,00

   ; Refs:
   ; https://superuser.com/a/1381836
   ```

</details>

### Uninstallation

```
cd ~/dotfiles
./uninstall.sh
cd ..
rm -rf dotfiles
```

## Known Issues

1. Neovim cannot be launched properly inside Windows tmux or MinTTY. Need to switch back to Vim for these environments. [#6751](https://github.com/neovim/neovim/issues/6751) [#8271](https://github.com/neovim/neovim/pull/8271) [#11112](https://github.com/neovim/neovim/issues/11112)

2. Tmux cannot be launched in Windows Terminal directly. Need to use `script -c tmux /dev/null` as workaround ([source](https://github.com/csdvrx/sixel-tmux)). [#5132](https://github.com/microsoft/terminal/issues/5132)

## To-Do

1. Make dotfiles folder able to be put anywhere on the filesystem instead of only `${HOME}/dotfiles`.
