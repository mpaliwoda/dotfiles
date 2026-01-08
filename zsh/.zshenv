#!/bin/zsh
# .zshenv - Zsh environment file, loaded always.

# NOTE: .zshenv needs to live at ~/.zshenv, not in $ZDOTDIR!

# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export ENVIRONMENT=development

# Hostname-based machine detection
export DOTFILES_HOSTNAME=$(hostname -s)
export IS_WORK_MACHINE=false
case "$DOTFILES_HOSTNAME" in
    m-a) export IS_WORK_MACHINE=true ;;
esac

# You can use .zprofile to set environment vars for non-login, non-interactive shells.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
