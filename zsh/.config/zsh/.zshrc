#!/bin/zsh
# .zshrc - Zsh file loaded on interactive shell sessions.

# Zsh options.
setopt extended_glob

# Autoload functions you might want to use with antidote.
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

if ! type "antidote" > /dev/null; then
  zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
  if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
    (
      source ${ZDOTDIR:-~}/.antidote/antidote.zsh
      antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
    )
  fi
  source ${zsh_plugins}.zsh
else
  antidote load
fi


eval "$(zoxide init zsh --cmd j)"

source "$HOME/.cargo/env"
source "$HOME/.secrets"
