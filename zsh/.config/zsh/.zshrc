#!/bin/zsh
# .zshrc - Zsh file loaded on interactive shell sessions.

# Zsh options.
setopt extended_glob
setopt AUTO_CD
setopt NO_CASE_GLOB
setopt INTERACTIVE_COMMENTS

# History options.
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt APPEND_HISTORY

# Autoload functions you might want to use with antidote.
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote

source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load


eval "$(zoxide init zsh --cmd j)"
[[ -f "$HOME/.secrets" ]] && source "$HOME/.secrets"

if command -v tmux >/dev/null 2>&1 && [[ -z "$TMUX" ]]; then
  tmux attach 2>/dev/null || tmux new
fi
