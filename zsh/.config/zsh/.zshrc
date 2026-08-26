#!/bin/zsh
# .zshrc - Zsh file loaded on interactive shell sessions.

# Zsh options.
setopt extended_glob

# History. atuin owns search; the plain zsh file is the write-through, and what
# `atuin import zsh` reads on a new machine.
# This has to be .zshrc, not .zprofile: macOS /etc/zshrc runs in between and
# pins SAVEHIST=1000, which is what was silently truncating history all along.
export HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

setopt append_history extended_history inc_append_history
setopt hist_ignore_dups hist_ignore_space hist_reduce_blanks hist_verify
# Lock with fcntl instead of the default .LOCK symlink, which a crashed shell
# leaves behind dangling and every later shell then waits on.
setopt hist_fcntl_lock

# First: mise owns starship, zoxide et al, needed by everything below.
eval "$(mise activate zsh)"

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
source "$HOME/.secrets"

# The -t check keeps tmux out of `zsh -c`, editor and tool shells.
if [[ -o interactive ]] && [[ -t 0 && -t 1 ]] &&
   [[ -z "$TMUX" ]] && command -v tmux >/dev/null 2>&1; then
  if tmux list-sessions >/dev/null 2>&1; then
    tmux attach || tmux new
  else
    tmux new
  fi
fi

export PATH="$HOME/.local/bin:$PATH"
