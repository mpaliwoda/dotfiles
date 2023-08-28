export TERM=xterm-kitty
export CLICOLOR=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTFILE="$HOME/.zhistory"

export EDITOR=/opt/homebrew/bin/nvim

export DOCKER_HOST="unix://$HOME/.colima/docker.sock"
export DOCKER_DEFAULT_PLATFORM=linux/amd64

export PYENV_ROOT="$HOME/.pyenv"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && \
    printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

export PATH="/usr/local/bin/:$PATH:$HOME/.local/bin:$PYENV_ROOT/bin:$HOME/apache-maven-3.9.2/bin:$HOME/.dotnet/tools:$HOME/.rvm/bin:/opt/homebrew/opt/curl/bin:/Users/marcin/.spicetify"
