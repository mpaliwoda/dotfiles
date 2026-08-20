#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${DOTFILES_REPO:-https://github.com/mpaliwoda/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Top-level dirs that are not stow packages.
NOT_STOWED=(macos)

info() { printf '\033[1;34m[INFO]\033[0m %s\n' "$1"; }
success() { printf '\033[1;32m[OK]\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m[WARN]\033[0m %s\n' "$1" >&2; }

# Piped from curl there is no script on disk, so clone and re-exec from there.
locate_repo() {
  if [[ -n "${BASH_SOURCE[0]:-}" && -f "${BASH_SOURCE[0]}" ]]; then
    DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    return
  fi

  if [[ -d "$DOTFILES_DIR/.git" ]]; then
    info "Using existing checkout at $DOTFILES_DIR"
  else
    info "Cloning $REPO_URL into $DOTFILES_DIR..."
    git clone --recurse-submodules "$REPO_URL" "$DOTFILES_DIR"
  fi

  exec bash "$DOTFILES_DIR/bootstrap.sh" "$@"
}

install_brew() {
  if command -v brew &>/dev/null; then
    success "Homebrew already installed"
  else
    info "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success "Homebrew installed"
  fi

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

install_bundle() {
  info "Running brew bundle..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
  success "Brew bundle complete"
}

sync_submodules() {
  info "Syncing submodules..."
  git -C "$DOTFILES_DIR" submodule sync --recursive
  git -C "$DOTFILES_DIR" submodule update --init --recursive
  success "Submodules up to date"
}

# stow refuses to overwrite a real file with a symlink, and a fresh macOS
# install ships a few (~/.zprofile and friends).
backup_conflicts() {
  local package="$1" target="$2" stamp
  stamp="$(date +%Y%m%d-%H%M%S)"

  while IFS= read -r -d '' file; do
    local rel="${file#"$DOTFILES_DIR/$package/"}"
    local dest="$target/$rel"
    [[ -e "$dest" && ! -L "$dest" ]] || continue
    warn "Backing up existing $dest -> $dest.bak-$stamp"
    mv "$dest" "$dest.bak-$stamp"
  done < <(package_files "$package")
}

# git, not find: keeps us out of the multi-GB Colima VM under colima/.
package_files() {
  local package="$1"
  if git -C "$DOTFILES_DIR" rev-parse --git-dir &>/dev/null; then
    git -C "$DOTFILES_DIR" ls-files -z -- "$package" |
      while IFS= read -r -d '' f; do printf '%s\0' "$DOTFILES_DIR/$f"; done
  else
    find "$DOTFILES_DIR/$package" -type f -print0
  fi
}

stow_dotfiles() {
  info "Stowing dotfiles..."
  local package
  for package in "$DOTFILES_DIR"/*/; do
    package="$(basename "$package")"

    if [[ " ${NOT_STOWED[*]} " == *" $package "* ]]; then
      continue
    fi

    if [[ -d "$DOTFILES_DIR/$package/etc" ]]; then
      if [[ "$(uname)" != "Linux" ]]; then
        info "Skipping $package (Linux only)"
        continue
      fi
      info "Stowing $package to /"
      sudo stow -d "$DOTFILES_DIR" -t / --restow "$package"
    else
      info "Stowing $package"
      backup_conflicts "$package" "$HOME"
      stow -d "$DOTFILES_DIR" -t "$HOME" --restow "$package"
    fi
  done
  success "All dotfiles stowed"
}

install_tools() {
  info "Installing mise-managed tools (this takes a while)..."
  mise trust "$DOTFILES_DIR/mise/.config/mise/config.toml"
  mise install
  success "Tools installed"
}

install_tmux_plugins() {
  local tpm="$HOME/.config/tmux/plugins/tpm/bin/install_plugins"
  if [[ ! -x "$tpm" ]]; then
    warn "tpm not found, skipping tmux plugin install"
    return
  fi
  info "Installing tmux plugins..."
  "$tpm"
  success "tmux plugins installed"
}

# .zshrc sources this unconditionally; without it every new shell errors out.
seed_secrets() {
  [[ -f "$HOME/.secrets" ]] || touch "$HOME/.secrets"
}

# git honours exactly one core.excludesFile, hence the concatenated ignore.
# Hostnames match zsh/.zshenv. Must run after stow_dotfiles.
configure_machine() {
  local is_work=false
  case "$(hostname -s)" in
    m-a) is_work=true ;;
  esac

  if [[ "$is_work" != true ]]; then
    info "Personal machine, deactivating work config"
    rm -f "$HOME/.config/git/config.local" "$HOME/.config/git/ignore.merged"
    return
  fi

  info "Work machine, generating git config"
  cat >"$HOME/.config/git/config.local" <<'EOF'
[include]
    path = config.work
[core]
    excludesFile = ~/.config/git/ignore.merged
EOF
  cat "$HOME/.config/git/ignore" "$HOME/.config/git/ignore.work" \
    >"$HOME/.config/git/ignore.merged"
  success "Work git config generated"
}

# macOS apps keep settings in ~/Library/Preferences, which cfprefsd caches and
# rewrites — symlinking those is unreliable, so import a snapshot instead.
# Refresh with: defaults export com.vorssaint.utils "macos/Vorssaint Settings.plist"
import_app_settings() {
  [[ "$(uname)" == "Darwin" ]] || return 0

  local settings="$DOTFILES_DIR/macos/Vorssaint Settings.plist"
  [[ -f "$settings" ]] || return 0

  # The app exports a {settings, vorssaintBackupVersion} envelope; `defaults
  # import` wants the inner dict on its own.
  local unwrapped
  unwrapped="$(mktemp -t vorssaint)"

  if ! plutil -extract settings xml1 -o "$unwrapped" "$settings" 2>/dev/null; then
    warn "Unexpected Vorssaint export format, skipping"
    rm -f "$unwrapped"
    return
  fi

  info "Importing Vorssaint settings..."
  osascript -e 'quit app id "com.vorssaint.utils"' 2>/dev/null || true
  defaults import com.vorssaint.utils "$unwrapped"
  rm -f "$unwrapped"
  success "Vorssaint settings imported"
}

start_services() {
  [[ "$(uname)" == "Darwin" ]] || return 0
  info "Starting borders..."
  brew services start borders
  success "Services started"
}

main() {
  locate_repo "$@"
  info "Bootstrapping dotfiles from $DOTFILES_DIR"
  install_brew
  install_bundle
  sync_submodules
  stow_dotfiles
  seed_secrets
  configure_machine
  install_tools
  install_tmux_plugins
  import_app_settings
  start_services
  success "Bootstrap complete! Restart your shell."
}

main "$@"
