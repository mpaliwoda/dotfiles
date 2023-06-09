eval $(/opt/homebrew/bin/brew shellenv)

export TERM=xterm-kitty
export CLICOLOR=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000

TO_SOURCE=("$HOME/.secrets" "$HOME/.aliases" "$HOME/.airhelp_aliases")
for file in "${TO_SOURCE[@]}"; do
    [ -f $file ] && source $file
done

export PATH="$PATH:/usr/local/bin"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && \
    printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"


eval "$(fasd --init auto)"
eval "$(rbenv init - zsh)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
. "$HOME/.cargo/env"
# . /Users/marcin.paliwoda/.rvm/scripts/rvm

export EDITOR=/opt/homebrew/bin/nvim
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"
