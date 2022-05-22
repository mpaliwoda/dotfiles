PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

eval $(/opt/homebrew/bin/brew shellenv)

export BASH_SILENCE_DEPRECATION_WARNING=1

export SHELL=/opt/homebrew/bin/bash
export TERM=xterm-kitty
export CLICOLOR=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export EDITOR=/opt/homebrew/bin/nvim

export BASH_IT="$HOME/Terminal/bash-it"
export BASH_IT_THEME='powerline'
export VCPROMPT_EXECUTABLE="$HOME/Terminal/vcprompt"

export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="$PATH:/usr/local/bin:$PYENV_ROOT/bin"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && \
    printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

source "$BASH_IT/bash_it.sh"

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=10000

shopt -s histappend
shopt -s checkwinsize

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion

  fi
fi

TO_SOURCE=("$HOME/.fzf.bash" "$HOME/.secrets" "$HOME/.bash_aliases" "$HOME/.airhelp_aliases")
for file in "${TO_SOURCE[@]}"; do
    [ -f $file ] && source $file
done

eval "$(fasd --init auto)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init - bash)"
eval "$(rbenv init -)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


source /Users/marcin.paliwoda/.config/broot/launcher/bash/br
