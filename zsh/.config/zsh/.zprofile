#!/bin/zsh
# .zprofile - Zsh file loaded on login.

# General exports
export TERM=xterm-256color
export CLICOLOR=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="bat"

export DOCKER_HOST="unix://${XDG_CONFIG_HOME}/colima/default/docker.sock"
export DOCKER_DEFAULT_PLATFORM=linux/amd64

export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTFILE="${ZDOTDIR}/.zhistory"


# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# Browser or sumtin
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

eval "$(mise activate zsh)"
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
