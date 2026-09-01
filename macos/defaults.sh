#!/usr/bin/env bash
# System defaults that aren't files, so stow can't manage them.
# Safe to re-run. Called from bootstrap.sh; also runnable on its own.
set -euo pipefail

[[ "$(uname)" == "Darwin" ]] || exit 0

info() { printf '\033[1;34m[INFO]\033[0m %s\n' "$1"; }

# Mission Control > "Displays have separate Spaces". The key is inverted: false
# means displays get their own Spaces. With it on (spans-displays = true), a
# native-fullscreen window blacks out every other monitor, which kills the
# AeroSpace workspace on the second display whenever a video goes fullscreen.
# Read at login only, so it takes effect after a log out/in.
info "Enabling separate Spaces per display..."
defaults write com.apple.spaces spans-displays -bool false

info "macOS defaults applied (log out and back in for Spaces changes)"
