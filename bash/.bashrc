# bash-it {{{

case $- in
    *i*) ;;
      *) return;;
esac


HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=5000
HISTFILESIZE=10000


shopt -s checkwinsize


[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


case "$TERM" in
    xterm-color) color_prompt=yes;;
esac


force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi


if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion

  fi
fi

export SHELL=/bin/bash
export TERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export CLICOLOR=1

export BASH_IT="$HOME/Terminal/bash-it"
export BASH_IT_THEME='powerline'
unset MAILCHECK
export SCM_CHECK=true
export VCPROMPT_EXECUTABLE="$HOME/Terminal/vcprompt"
source $BASH_IT/bash_it.sh

# }}}

eval "$(fasd --init auto)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/Terminal:$HOME/.pyenv/bin:/usr/lib/postgresql/10/bin:/usr/local/bin:$PATH"

if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/opt/mysql@5.7/bin:$PATH"
elif [[ "$OSTYPE" == "linux"* ]]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
    # Start Docker daemon automatically when logging in if not running.'
    RUNNING=`ps aux | grep dockerd | grep -v grep`
    if [ -z "$RUNNING" ]; then
        sudo dockerd > /dev/null 2>&1 &
        disown
    fi
fi

TO_SOURCE=("$HOME/.fzf.bash" "$HOME/.bash_aliases" "$HOME/.secrets" "$HOME/.airhelp_aliases")
for file in "${TO_SOURCE[@]}"; do
    [ -f $file ] && source $file
done


export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"


export EDITOR=/usr/local/bin/nvim

export NVM_DIR="/home/marcin/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DOTNET_ROOT=$HOME/dotnet
export PATH=$PATH:$HOME/dotnet
export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
