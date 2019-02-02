# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

pyclean() {
    find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
}

alias vim=nvim
alias vi=nvim
alias v=nvim

alias gtree='git log --graph --pretty=oneline --abbrev-commit'
alias untracked='git ls-files --others --exclude-standard'

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ll='ls -alF'
alias la='ls -1a'
alias l='ls -CF'

function docker_up {
    COMMAND=""
    RUN="run -e --rm"
    TESTS=false
    COMPOSE_FILE="docker-compose.yml"

    for var in $@; do
        if [[ $var == '--with-token' ]]; then
            ARG_NAME="GITHUB_TOKEN"
            TOKEN=$GITHUB_ACCESS_TOKEN
            BUILD_ARGS="$BUILD_ARGS --build-arg $ARG_NAME=$TOKEN"
        elif [[ $var == "--test" ]]; then
            TESTS=true
            if [ -f docker-compose.test.yml ]; then
                COMPOSE_FILE="docker-compose.test.yml"
            fi

            if `grep -q mypy $COMPOSE_FILE`; then
                MYPY=true
            else
                MYPY=false
            fi
        elif [[ $var != "--*" ]]; then
            echo $var
            build_args="$BUILD_ARGS $var"
        fi
    done

    COMMAND="docker-compose -f $COMPOSE_FILE"

    eval $COMMAND build $BUILD_ARGS

    if [ "$TESTS" = true ]; then
        eval $COMMAND $RUN tests
        eval $COMMAND $RUN flake
        if [ "$MYPY" = true ]; then
            eval $COMMAND $RUN mypy
        fi
        eval $COMMAND down --remove-orphan
    else
        eval $COMMAND up
    fi
}

alias up=docker_up
alias down='docker-compose down'
alias pip='pip3'


alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
alias ch="python ~/Terminal/fuzzy_checkout.py"

function j {
    fasd_cd -id "$1"
}


function rename_remote {
    old_name="$1"
    new_name="$2"

    git checkout "$old_name"

    if [[ "$?" -ne 0 ]]; then
        git add .
        git stash
        git checkout "$old_name"
    fi

    git branch -m "$new_name"
    git push origin -u "$new_name"
}


alias rename-local="git branch -m $1"
alias rename-remote=rename_remote
