#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${DOTFILES_REPO:-https://github.com/mpaliwoda/dotfiles.git}"
REPO_BRANCH="${DOTFILES_BRANCH:-}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

MACHINE_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/machine"
MACHINE_KIND=""

# A remote dev box: headless Linux reached over ssh, no brew, no tmux, dnf for
# the handful of system packages and mise for everything else.
REMOTE_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/dotfiles/remote"
REMOTE_MACHINE=""

# Top-level dirs that are not stow packages.
NOT_STOWED=(macos)
# Stow packages that only make sense on a machine you sit at.
DESKTOP_ONLY=(aerospace borders dual-keys ghostty tmux)

# What the remote bootstrap needs from the distro. The first list must
# install; the second is nice to have and skipped when a repo lacks it (stow
# lives in EPEL on RHEL, and there is a symlink fallback for it below).
SYSTEM_PACKAGES=(git zsh curl tar gzip unzip xz make gcc gcc-c++)
SYSTEM_PACKAGES_OPTIONAL=(htop tree stow)

info() { printf '\033[1;34m[INFO]\033[0m %s\n' "$1"; }
success() { printf '\033[1;32m[OK]\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m[WARN]\033[0m %s\n' "$1" >&2; }

usage() {
  cat <<EOF
Usage: bootstrap.sh [--work | --personal] [--remote | --local]

  --work       set this machine up with the work git/mise/shell config
  --personal   set this machine up without the work config
  --remote     headless remote dev machine: dnf + mise, no brew/tmux/GUI
  --local      a machine you sit at (the default unless run over ssh)
  -h, --help   show this help

With neither flag of a pair the script asks, defaulting to the previous
answer. DOTFILES_MACHINE=work|personal and DOTFILES_REMOTE=true|false in the
environment do the same as the flags.
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --work) MACHINE_KIND=work ;;
      --personal) MACHINE_KIND=personal ;;
      --remote) REMOTE_MACHINE=true ;;
      --local) REMOTE_MACHINE=false ;;
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

saved_remote() {
  local saved=""
  [[ -r "$REMOTE_FILE" ]] || return 1
  read -r saved <"$REMOTE_FILE" || true
  case "$saved" in
    true | false) printf '%s' "$saved" ;;
    *) return 1 ;;
  esac
}

# Linux over ssh is the remote box; anything else is a desktop.
guess_remote() {
  if [[ "$(uname)" == Linux && -n "${SSH_CONNECTION:-}" ]]; then
    printf 'true'
  else
    printf 'false'
  fi
}

resolve_remote() {
  local saved default hint answer
  saved="$(saved_remote || true)"

  if [[ -z "$REMOTE_MACHINE" && -n "${DOTFILES_REMOTE:-}" ]]; then
    case "$DOTFILES_REMOTE" in
      true | false) REMOTE_MACHINE="$DOTFILES_REMOTE" ;;
      *) warn "Ignoring invalid DOTFILES_REMOTE=$DOTFILES_REMOTE" ;;
    esac
  fi

  if [[ -n "$REMOTE_MACHINE" ]]; then
    [[ "$REMOTE_MACHINE" == true ]] && info "Configuring as a remote dev machine"
    return
  fi

  default="${saved:-$(guess_remote)}"
  if [[ "$default" == true ]]; then hint="[Y/n]"; else hint="[y/N]"; fi

  if ! : 2>/dev/null <>/dev/tty; then
    REMOTE_MACHINE="$default"
    warn "No terminal to ask on, assuming remote=$REMOTE_MACHINE (use --remote or --local)"
    return
  fi

  while true; do
    printf '\033[1;34m[INFO]\033[0m Is this a remote (headless) dev machine? %s ' "$hint" >/dev/tty
    read -r answer </dev/tty || answer=""
    if [[ -z "$answer" ]]; then
      if [[ "$default" == true ]]; then answer=y; else answer=n; fi
    fi
    case "$answer" in
      [Yy] | [Yy][Ee][Ss] | remote)
        REMOTE_MACHINE=true
        return
        ;;
      [Nn] | [Nn][Oo] | local)
        REMOTE_MACHINE=false
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
    info "Cloning $REPO_URL${REPO_BRANCH:+ ($REPO_BRANCH)} into $DOTFILES_DIR..."
    git clone --recurse-submodules ${REPO_BRANCH:+--branch "$REPO_BRANCH"} \
      "$REPO_URL" "$DOTFILES_DIR"
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

# Runs a package-manager command as root, whichever way gets us there.
as_root() {
  if [[ "$(id -u)" -eq 0 ]]; then
    "$@"
  elif command -v sudo &>/dev/null; then
    sudo "$@"
  else
    return 1
  fi
}

# RHEL and friends only: everything else on a remote box comes from mise.
install_system_packages() {
  local pm="" pkg
  if command -v dnf &>/dev/null; then
    pm=dnf
  elif command -v yum &>/dev/null; then
    pm=yum
  else
    warn "No dnf/yum here; install these yourself: ${SYSTEM_PACKAGES[*]}"
    return
  fi

  info "Installing system packages with $pm..."
  if ! as_root "$pm" install -y "${SYSTEM_PACKAGES[@]}"; then
    warn "$pm install failed; install these yourself: ${SYSTEM_PACKAGES[*]}"
  fi
  for pkg in "${SYSTEM_PACKAGES_OPTIONAL[@]}"; do
    command -v "$pkg" &>/dev/null && continue
    as_root "$pm" install -y -q "$pkg" 2>/dev/null ||
      info "$pkg is not in the enabled repos, skipping"
  done

  if ! command -v zsh &>/dev/null; then
    warn "zsh is not installed; the shell config needs it"
  fi
  success "System packages installed"
}

# No brew on a remote box, so mise comes from its own installer and lives in
# ~/.local/bin, which .zprofile already puts on PATH.
install_mise() {
  export PATH="$HOME/.local/bin:$PATH"
  if command -v mise &>/dev/null; then
    success "mise already installed"
    return
  fi
  info "Installing mise..."
  curl -fsSL https://mise.run | MISE_INSTALL_PATH="$HOME/.local/bin/mise" sh
  success "mise installed"
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
  local package="$1" target="$2" stamp repo
  stamp="$(date +%Y%m%d-%H%M%S)"
  repo="$(cd "$DOTFILES_DIR" && pwd -P)"

  while IFS= read -r -d '' file; do
    local rel="${file#"$DOTFILES_DIR/$package/"}"
    local dest="$target/$rel"
    [[ -e "$dest" && ! -L "$dest" ]] || continue
    local resolved
    resolved="$(cd "$(dirname "$dest")" && pwd -P)/$(basename "$dest")"
    [[ "$resolved" != "$repo/"* ]] || continue
    warn "Backing up existing $dest -> $dest.bak-$stamp"
    mv "$dest" "$dest.bak-$stamp"
  done < <(package_files "$package")
}

# Fallback for when stow is not installed (it lives in EPEL on RHEL). Folds
# like stow does: a directory the target lacks becomes one symlink, an
# existing real directory (~/.config) is descended into. Whole-directory links
# matter, since .zshrc globs its functions dir with a plain-files qualifier
# that a symlink per file would not satisfy.
link_tree() {
  local src="$1" dest="$2" entry name
  for entry in "$src"/* "$src"/.[!.]* "$src"/..?*; do
    [[ -e "$entry" || -L "$entry" ]] || continue
    name="$(basename "$entry")"
    if [[ -d "$dest/$name" && ! -L "$dest/$name" ]]; then
      link_tree "$entry" "$dest/$name"
      continue
    fi
    if [[ -e "$dest/$name" && ! -L "$dest/$name" ]]; then
      warn "Backing up existing $dest/$name -> $dest/$name.bak-$LINK_STAMP"
      mv "$dest/$name" "$dest/$name.bak-$LINK_STAMP"
    fi
    ln -sfn "$entry" "$dest/$name"
  done
}

link_package() {
  LINK_STAMP="$(date +%Y%m%d-%H%M%S)"
  link_tree "$DOTFILES_DIR/$1" "$2"
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

    if [[ "$REMOTE_MACHINE" == true && " ${DESKTOP_ONLY[*]} " == *" $package "* ]]; then
      info "Skipping $package (desktop only)"
      continue
    fi

    if [[ -d "$DOTFILES_DIR/$package/etc" ]]; then
      if [[ "$(uname)" != "Linux" ]]; then
        info "Skipping $package (Linux only)"
        continue
      fi
      info "Stowing $package to /"
      sudo stow -d "$DOTFILES_DIR" -t / --restow "$package"
    elif command -v stow &>/dev/null; then
      info "Stowing $package"
      backup_conflicts "$package" "$HOME"
      stow -d "$DOTFILES_DIR" -t "$HOME" --restow "$package"
    else
      info "Linking $package (no stow)"
      link_package "$package" "$HOME"
    fi
  done
  success "All dotfiles stowed"
}

# Mirrors the MISE_ENV logic in zsh/.config/zsh/.zprofile.
mise_env() {
  local envs
  if [[ "$REMOTE_MACHINE" == true ]]; then envs=remote; else envs=desktop; fi
  [[ "$MACHINE_KIND" == work ]] && envs="$envs,work"
  printf '%s' "$envs"
}

install_tools() {
  local config
  export MISE_ENV
  MISE_ENV="$(mise_env)"
  info "Installing mise-managed tools for MISE_ENV=$MISE_ENV (this takes a while)..."
  # The symlinks resolve into the repo, outside the directories mise trusts
  # by default, so every layer needs trusting, not just config.toml.
  for config in "$DOTFILES_DIR"/mise/.config/mise/config*.toml; do
    mise trust "$config"
  done
  if mise install; then
    success "Tools installed"
  else
    warn "Some mise tools failed to install, continuing. Retry with: mise install"
  fi
}

install_tmux_plugins() {
  [[ "$REMOTE_MACHINE" == true ]] && return 0
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
# Must run after stow_dotfiles.
configure_machine() {
  mkdir -p "$(dirname "$MACHINE_FILE")"
  printf '%s\n' "$MACHINE_KIND" >"$MACHINE_FILE"
  printf '%s\n' "$REMOTE_MACHINE" >"$REMOTE_FILE"

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

# RHEL logs you into bash. chsh wants a password, so it only runs with a
# terminal; LDAP accounts usually cannot chsh at all, hence the fallback hint.
set_default_shell() {
  [[ "$REMOTE_MACHINE" == true ]] || return 0
  local zsh
  zsh="$(command -v zsh || true)"
  [[ -n "$zsh" ]] || return 0
  [[ "$(basename "${SHELL:-}")" != zsh ]] || return 0

  if : 2>/dev/null <>/dev/tty && chsh -s "$zsh" </dev/tty; then
    success "Default shell set to $zsh"
  else
    warn "Could not change the login shell; run: chsh -s $zsh"
    warn "  or add to ~/.bash_profile: [ -x $zsh ] && exec $zsh -l"
  fi
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
  resolve_remote
  if [[ "$REMOTE_MACHINE" == true ]]; then
    install_system_packages
    install_mise
  else
    install_brew
    install_bundle
  fi
  sync_submodules
  stow_dotfiles
  seed_secrets
  configure_machine
  install_tools
  install_tmux_plugins
  set_default_shell
  apply_macos_defaults
  import_app_settings
  start_services
  success "Bootstrap complete! Restart your shell."
}

main "$@"
