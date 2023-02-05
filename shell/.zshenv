eval $(/opt/homebrew/bin/brew shellenv)

export TERM=xterm-kitty
export CLICOLOR=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR=/opt/homebrew/bin/nvim

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000

TO_SOURCE=("$HOME/.secrets" "$HOME/.aliases" "$HOME/.airhelp_aliases")
for file in "${TO_SOURCE[@]}"; do
    [ -f $file ] && source $file
done

export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="$PATH:/usr/local/bin:$PYENV_ROOT/bin"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && \
    printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"


eval "$(fasd --init auto)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init - bash)"
eval "$(rbenv init -)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
. "$HOME/.cargo/env"
