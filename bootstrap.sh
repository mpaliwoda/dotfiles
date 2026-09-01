#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${DOTFILES_REPO:-https://github.com/mpaliwoda/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Remembers the answer to "is this a work machine?" so later runs and every
# shell (see zsh/.zshenv) agree without having to guess from the hostname.
MACHINE_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/machine"
MACHINE_KIND=""

# Top-level dirs that are not stow packages.
NOT_STOWED=(macos)

info() { printf '\033[1;34m[INFO]\033[0m %s\n' "$1"; }
success() { printf '\033[1;32m[OK]\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m[WARN]\033[0m %s\n' "$1" >&2; }

usage() {
  cat <<EOF
Usage: bootstrap.sh [--work | --personal]

  --work       set this machine up with the work git/mise/shell config
  --personal   set this machine up without the work config
  -h, --help   show this help

With neither flag the script asks, defaulting to the previous answer.
DOTFILES_MACHINE=work|personal in the environment does the same as the flags.
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --work) MACHINE_KIND=work ;;
      --personal) MACHINE_KIND=personal ;;
      -h | --help)
        usage
        exit 0
        ;;
      *)
        warn "Unknown argument: $1"
        usage >&2
        exit 1
        ;;
    esac
    shift
  done
}

saved_machine_kind() {
  local saved=""
  [[ -r "$MACHINE_FILE" ]] || return 1
  read -r saved <"$MACHINE_FILE" || true
  case "$saved" in
    work | personal) printf '%s' "$saved" ;;
    *) return 1 ;;
  esac
}

# Hostnames get reused, machines get reimaged and a wrong guess quietly leaks
# work config into a personal checkout, so ask instead of sniffing.
resolve_machine_kind() {
  local saved default hint answer
  saved="$(saved_machine_kind || true)"

  if [[ -z "$MACHINE_KIND" && -n "${DOTFILES_MACHINE:-}" ]]; then
    case "$DOTFILES_MACHINE" in
      work | personal) MACHINE_KIND="$DOTFILES_MACHINE" ;;
      *) warn "Ignoring invalid DOTFILES_MACHINE=$DOTFILES_MACHINE" ;;
    esac
  fi

  if [[ -n "$MACHINE_KIND" ]]; then
    info "Configuring as a $MACHINE_KIND machine"
    return
  fi

  default="${saved:-personal}"
  if [[ "$default" == work ]]; then hint="[Y/n]"; else hint="[y/N]"; fi

  # Curl-piped runs have the script on stdin, so read the answer off the tty.
  # /dev/tty exists even with no controlling terminal, hence the open test.
  if ! : 2>/dev/null <>/dev/tty; then
    MACHINE_KIND="$default"
    warn "No terminal to ask on, assuming a $MACHINE_KIND machine (use --work or --personal)"
    return
  fi

  while true; do
    printf '\033[1;34m[INFO]\033[0m Is this a work machine? %s ' "$hint" >/dev/tty
    read -r answer </dev/tty || answer=""
    [[ -n "$answer" ]] || answer="${default:0:1}"
    case "$answer" in
      [Yy] | [Yy][Ee][Ss] | [Ww] | work)
        MACHINE_KIND=work
        return
        ;;
      [Nn] | [Nn][Oo] | [Pp] | personal)
        MACHINE_KIND=personal
        return
        ;;
      *) warn "Answer y or n" ;;
    esac
  done
}

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
# The recorded answer is what zsh/.zshenv reads. Must run after stow_dotfiles.
configure_machine() {
  mkdir -p "$(dirname "$MACHINE_FILE")"
  printf '%s\n' "$MACHINE_KIND" >"$MACHINE_FILE"

  if [[ "$MACHINE_KIND" != work ]]; then
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

apply_macos_defaults() {
  [[ "$(uname)" == "Darwin" ]] || return 0

  local script="$DOTFILES_DIR/macos/defaults.sh"
  [[ -f "$script" ]] || return 0

  bash "$script"
  success "macOS defaults applied"
}

# macOS apps keep settings in ~/Library/Preferences, which cfprefsd caches and
# rewrites, so symlinking those is unreliable; import a snapshot instead.
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
  parse_args "$@"
  locate_repo "$@"
  info "Bootstrapping dotfiles from $DOTFILES_DIR"
  resolve_machine_kind
  install_brew
  install_bundle
  sync_submodules
  stow_dotfiles
  seed_secrets
  configure_machine
  install_tools
  install_tmux_plugins
  apply_macos_defaults
  import_app_settings
  start_services
  success "Bootstrap complete! Restart your shell."
}

main "$@"
