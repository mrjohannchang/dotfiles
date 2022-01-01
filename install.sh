#!/usr/bin/env bash

set -e

DOTFILES_DIR=$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)

entry_point="$0"

COLOR_RESET=$(tput sgr0)
COLOR_RED=$(tput setaf 124)
COLOR_BOLD=$(tput bold)

ERR() {
  echo -e [${COLOR_BOLD}${COLOR_RED}ERROR${COLOR_RESET}] "$@" >&2
  exit 2
}

INFO() {
  echo -e [${COLOR_BOLD}INFO${COLOR_RESET}] "$@"
}

WARN() {
  echo -e [${COLOR_BOLD}${COLOR_RED}WARNING${COLOR_RESET}] "$@" >&2
}

mkdir_and_check() {
  local d="$1"

  if [ ! -d "$d" ]; then
    mkdir -p "$d"
    if [ ! -d "$d" ]; then
      ERR "$d should be a folder"
    fi
    echo "$d created"
  fi
}

yes_or_no_question() {
  # assign local variable from function in linux bash a new value
  # https://stackoverflow.com/questions/22527325/assign-local-variable-from-function-in-linux-bash-a-new-value
  local question="$1"
  local default=n
  local hint="[y/N]"

  if [[ "${2,,}" == y* ]]; then
    default=y
    hint="[Y/n]"
  fi

  echo -en [${COLOR_BOLD}Q${COLOR_RESET}] "$question $hint "
  local input
  read input
  if [ -z "$input" ]; then
    input="$default"
  fi
  if [[ "${input,,}" == "y" ]]; then
    return 0
  else
    return 1
  fi
}

install_target() {
  local src="$1"
  local dest="$2"

  local category="${src%%/*}"
  local stripped_src="${src#$category/}"

  case "$category" in
    home)
      local prefix="${HOME}/"
      ;;
    root)
      local prefix="/"
      ;;
    *)
      WARN "target $src is not supported"
      return 1
      ;;
  esac

  if [ -z "$dest" ]; then
    dest="${prefix}${stripped_src}"
  fi

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    if [ -e "${dest}.bak" ]; then
      ERR "backup of $dest is already exists"
    fi
    mv "$dest" "${dest}.bak"
    echo "$dest was backed up"
  fi

  ln -s "${DOTFILES_DIR}/${src}" "$dest"
  echo "$dest was installed"
}

install() {
  local bg=dark
  if yes_or_no_question "Is your terimnal background \"light\"?" ; then
    bg=light
  fi

  mkdir_and_check "${DOTFILES_DIR}/3rdparty/zsh-snap-plugins"
  mkdir_and_check "${HOME}/.config"
  mkdir_and_check "${HOME}/bin.d"
  case "${OSTYPE,,}" in
    darwin*)
      mkdir_and_check "${HOME}/Library/Fonts"
      ;;
    linux*)
      mkdir_and_check "${HOME}/.local/share/fonts"
      mkdir_and_check "${HOME}/.config/fontconfig/conf.d"
      ;;
  esac

  install_target "home/bin.d/changyuheng"
  install_target "home/.zprofile"
  install_target "home/.zshrc"
  if [ "$bg" = "light" ]; then
    install_target "home/.zshrc.light"
  fi

  yes_or_no_question "Install dircolors?"
  if [ "$bg" = "light" ]; then
    install_target "home/.dircolors.light" "${HOME}/.dircolors"
  else
    install_target "home/.dircolors"
  fi

  install_target "home/.tmux"
  install_target "home/.tmux.conf"
  if [ "$bg" = "light" ]; then
    install_target "home/.tmux.light.conf"
  fi
  case "${OSTYPE,,}" in
    darwin*)
      install_target "home/.tmux.darwin.conf"
      ;;
  esac

  install_target "home/.ideavimrc"

  if yes_or_no_question "Install Git configurations (cannot be undone)?"; then
    git config --global alias.show-tracked-ignored "ls-files -i --exclude-standard"
    echo 'alias.show-tracked-ignored = "ls-files -i --exclude-standard"'

    git config --global core.editor nvim
    echo "core.editor = nvim"

    git config --global core.quotePath false
    echo "core.quotePath = false"

    git config --global color.ui auto
    echo "color.ui = auto"

    git config --global diff.algorithm patience
    echo "diff.algorithm = patience"

    git config --global diff.tool nvimdiff
    echo "diff.tool = nvimdiff"

    git config --global difftool.prompt false
    echo "difftool.prompt = false"

    git config --global difftool.nvimdiff.cmd 'nvim -d "$LOCAL" "$REMOTE" -c "wincmd w" -c "wincmd L"'
    echo 'difftool.nvimdiff.cmd = nvim -d "$LOCAL" "$REMOTE" -c "wincmd w" -c "wincmd L"'

    git config --global merge.tool nvimdiff
    echo "merge.tool = nvimdiff"

    git config --global mergetool.prompt true
    echo "mergetool.prompt = true"

    git config --global mergetool.nvimdiff.cmd 'nvim -d "$LOCAL" "$REMOTE" "$MERGED" -c "wincmd w" -c "wincmd J"'
    echo 'mergetool.nvimdiff.cmd nvim -d "$LOCAL" "$REMOTE" "$MERGED" -c "wincmd w" -c "wincmd J"'

    git config --global pull.ff only
    echo "pull.ff = only"

    git config --global push.default simple
    echo "push.default = simple"
  fi

  case "${OSTYPE,,}" in
    darwin*)
      install_target "home/Library/Fonts/Monaco for Powerline.otf"
      ;;

    linux*)
      install_target "home/.config/fontconfig/conf.d/20-noto-cjk.conf"

      install_target "home/.local/share/fonts/jf-openhuninn-1.1.ttf"
      install_target "home/.config/fontconfig/conf.d/30-jf-openhuninn.conf"

      install_target "home/.local/share/fonts/Hack Bold Italic Nerd Font Complete Mono.ttf"
      install_target "home/.local/share/fonts/Hack Bold Italic Nerd Font Complete.ttf"
      install_target "home/.local/share/fonts/Hack Bold Nerd Font Complete Mono.ttf"
      install_target "home/.local/share/fonts/Hack Bold Nerd Font Complete.ttf"
      install_target "home/.local/share/fonts/Hack Italic Nerd Font Complete Mono.ttf"
      install_target "home/.local/share/fonts/Hack Italic Nerd Font Complete.ttf"
      install_target "home/.local/share/fonts/Hack Regular Nerd Font Complete Mono.ttf"
      install_target "home/.local/share/fonts/Hack Regular Nerd Font Complete.ttf"

      fc-cache -fv
      ;;
  esac

  INFO "Installation has been completed"
}

uninstall_target() {
  local f="$1"

  if [[ ! -e "$f" && ! -L "$f" ]]; then
    return
  fi

  local readlink=readlink
  case "${OSTYPE,,}" in
    darwin*)
      readlink=greadlink
      ;;
  esac

  if [ ! -L "$f" ] || [[ "$($readlink -f "$f")" != "${DOTFILES_DIR}/"* ]]; then
    WARN "$f skipped"
    return
  fi

  unlink "$f"
  echo "$f was uninstalled"

  if [ -e "${f}.bak" ]; then
    mv "${f}.bak" "$f"
    echo "backup of ${f} was restored"
  fi
}

uninstall() {
  uninstall_target "${HOME}/bin.d/changyuheng"
  uninstall_target "${HOME}/.bash_aliases"
  uninstall_target "${HOME}/.bash_completion.d"
  uninstall_target "${HOME}/.bashrc"
  uninstall_target "${HOME}/.profile"
  uninstall_target "${HOME}/.zprofile"
  uninstall_target "${HOME}/.zshrc"
  uninstall_target "${HOME}/.zshrc.light"

  uninstall_target "${HOME}/.dircolors"

  uninstall_target "${HOME}/.screenrc"
  uninstall_target "${HOME}/.tmux"
  uninstall_target "${HOME}/.tmux.conf"
  uninstall_target "${HOME}/.tmux.darwin.conf"
  uninstall_target "${HOME}/.tmux.light.conf"

  uninstall_target "${HOME}/.vim"
  uninstall_target "${HOME}/.vimrc"
  uninstall_target "${HOME}/.ideavimrc"
  uninstall_target "${HOME}/.pentadactylrc"
  uninstall_target "${HOME}/.vimperatorrc"

  uninstall_target "${HOME}/Library/Fonts/Monaco for Powerline.otf"
  uninstall_target "${HOME}/.local/share/fonts/PowerlineSymbols.otf"
  uninstall_target "${HOME}/.config/fontconfig/conf.d/10-powerline-symbols.conf"
  uninstall_target "${HOME}/.config/fontconfig/conf.d/20-noto-cjk.conf"
  uninstall_target "${HOME}/.local/share/fonts/jf-openhuninn-1.1.ttf"
  uninstall_target "${HOME}/.config/fontconfig/conf.d/30-jf-openhuninn.conf"
  uninstall_target "${HOME}/.local/share/fonts/Hack Bold Italic Nerd Font Complete Mono.ttf"
  uninstall_target "${HOME}/.local/share/fonts/Hack Bold Italic Nerd Font Complete.ttf"
  uninstall_target "${HOME}/.local/share/fonts/Hack Bold Nerd Font Complete Mono.ttf"
  uninstall_target "${HOME}/.local/share/fonts/Hack Bold Nerd Font Complete.ttf"
  uninstall_target "${HOME}/.local/share/fonts/Hack Italic Nerd Font Complete Mono.ttf"
  uninstall_target "${HOME}/.local/share/fonts/Hack Italic Nerd Font Complete.ttf"
  uninstall_target "${HOME}/.local/share/fonts/Hack Regular Nerd Font Complete Mono.ttf"
  uninstall_target "${HOME}/.local/share/fonts/Hack Regular Nerd Font Complete.ttf"

  INFO "Uninstallation has been completed"
}

case "${OSTYPE,,}" in
  cygwin*|msys*)
    # Enable the symbolic link support on Windows
    export MSYS=winsymlinks:nativestrict
    ;;
esac

if [[ "$entry_point" == *bash ]]; then
  ERR "File was sourced but not executed"
fi

cd "$DOTFILES_DIR"

if yes_or_no_question "Continue to uninstall?"; then
  uninstall
fi

if [[ $(basename "$BASH_SOURCE") == "install"* ]]; then
  if yes_or_no_question "Continue to install?"; then
    install
  fi
fi
