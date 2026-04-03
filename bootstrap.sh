#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_PACKAGES=(bat colima dual-keys ghostty git kitty lsd mise neovim starship tmux yazi zsh)

info() { printf '\033[1;34m[INFO]\033[0m %s\n' "$1"; }
success() { printf '\033[1;32m[OK]\033[0m %s\n' "$1"; }
error() { printf '\033[1;31m[ERROR]\033[0m %s\n' "$1" >&2; }

install_brew() {
  if command -v brew &>/dev/null; then
    success "Homebrew already installed"
    return
  fi

  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for the rest of this script
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi

  success "Homebrew installed"
}

install_bundle() {
  info "Running brew bundle..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
  success "Brew bundle complete"
}

stow_dotfiles() {
  info "Stowing dotfiles..."
  for package in "${STOW_PACKAGES[@]}"; do
    info "Stowing $package"
    stow -d "$DOTFILES_DIR" -t "$HOME" --restow "$package"
  done
  success "All dotfiles stowed"
}

main() {
  info "Bootstrapping dotfiles from $DOTFILES_DIR"
  install_brew
  install_bundle
  stow_dotfiles
  success "Bootstrap complete!"
}

main "$@"
