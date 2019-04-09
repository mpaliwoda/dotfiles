# Add an "alert" alias for long running commands.  Use like so:
# $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


alias v=nvim
alias vi=nvim
alias vim=nvim

alias gtree='git log --graph --pretty=oneline --abbrev-commit'
alias untracked='git ls-files --others --exclude-standard'

# enable color support of ls and also add handy aliases
alias dir='dir --color=auto'
alias ls='ls --color=auto'
alias vdir='vdir --color=auto'

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

alias l='ls -CF'
alias la='ls -1a'
alias ll='ls -alF'

alias ch="fuzzy_checkout.py"
alias pip='pip3'
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"


pyclean() {
    find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
}


function j {
    fasd_cd -id "$1"
}


current_branch () {
    git branch | grep \* | cut -d ' ' -f2
}


__rename_remote () {
    new_name="$1"
    old_name=$(current_branch)

    git branch -m $old_name $new_name
    git push origin --delete $old_name
    push
}


push () {
    git push origin -u $(current_branch)
}


rename() {
    case $1 in
        local)
            git branch -m $(current_branch) "$2"
            ;;
        remote)
            __rename_remote $2
            ;;
        *)
            printf "You're called: 'Idiot' from now on\\n"
            ;;
    esac
}
