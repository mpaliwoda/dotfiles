#!/usr/bin/env ruby
# frozen_string_literal: true

cask_args appdir: '/Applications' if OS.mac?

tap 'nikitabobko/tap' if OS.mac?
tap 'felixkratz/formulae' if OS.mac?

# Tools mise can manage live in mise/.config/mise/config.toml instead.
brew 'coreutils'
brew 'git'
brew 'git-delta'
brew 'htop'
brew 'mise'
brew 'neovim'
brew 'poppler'
brew 'stow'
brew 'tlrc'
brew 'tmux'
brew 'tree'

brew 'docker', link: false
brew 'docker-buildx'
# colima comes from mise, but its limactl does not.
brew 'lima'

brew 'felixkratz/formulae/borders' if OS.mac?

cask 'nikitabobko/tap/aerospace' if OS.mac?
cask 'alt-tab' if OS.mac?
cask 'bruno' if OS.mac?
cask 'discord' if OS.mac?
cask 'font-mononoki-nerd-font' if OS.mac?
cask 'ghostty' if OS.mac?
cask 'hyperkey' if OS.mac?
cask 'protonvpn' if OS.mac?
cask 'qbittorrent' if OS.mac?
cask 'raycast' if OS.mac?
cask 'sf-symbols' if OS.mac?
cask 'slack' if OS.mac?
cask 'spotify' if OS.mac?
# Replaces caffeine (keep-awake) and jordanbaird-ice (menu bar).
cask 'vorssaint' if OS.mac?
cask 'zen' if OS.mac?
