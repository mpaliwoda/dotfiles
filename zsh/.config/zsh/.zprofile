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

export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/.local/{,s}bin(N)
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# Work machine configuration
if [[ "$IS_WORK_MACHINE" == "true" ]]; then
    # Additional PATH entries for work
    path=($HOME/.rd/bin $path)
fi

# Which mise config layers to load on top of config.toml; see the comment
# there. bootstrap.sh computes the same list when it runs `mise install`.
mise_envs=()
if [[ "$IS_REMOTE_MACHINE" == "true" ]]; then
    mise_envs+=(remote)
else
    mise_envs+=(desktop)
fi
[[ "$IS_WORK_MACHINE" == "true" ]] && mise_envs+=(work)
export MISE_ENV=${(j:,:)mise_envs}
unset mise_envs

# Browser or sumtin
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi


source ${ZDOTDIR:-~}/.antidote/antidote.zsh
