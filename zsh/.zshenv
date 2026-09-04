#!/bin/zsh
# .zshenv - Zsh environment file, loaded always.

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!

# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export ENVIRONMENT=development

export IS_WORK_MACHINE=false
if [[ -r "$XDG_CONFIG_HOME/dotfiles/machine" ]] &&
   [[ "$(<"$XDG_CONFIG_HOME/dotfiles/machine")" == work ]]; then
    export IS_WORK_MACHINE=true
fi

# A headless box reached over ssh: no tmux, no GUI packages, no brew.
export IS_REMOTE_MACHINE=false
if [[ -r "$XDG_CONFIG_HOME/dotfiles/remote" ]] &&
   [[ "$(<"$XDG_CONFIG_HOME/dotfiles/remote")" == true ]]; then
    export IS_REMOTE_MACHINE=true
fi

# You can use .zprofile to set environment vars for non-login, non-interactive shells.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
