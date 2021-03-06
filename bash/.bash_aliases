alias v=nvim
alias vi=nvim
alias vim=nvim

alias gtree='git log --graph --pretty=oneline --abbrev-commit'
alias untracked='git ls-files --others --exclude-standard'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias l='ls -CF'
alias la='ls -1a'
alias ll='ls -alF'

alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
alias ch="fuzzy_checkout.py"

pyclean () {
    __clean "(__pycache__|\.pyc|\.pyo$|.mypy_cache|.pytest_cache|.benchmarks)"
}


ropeclean () {
    __clean ".ropeproject"
}


__clean () {
    find . | grep -E "$1" | xargs rm -rf
}


j () {
    fasd_cd -id "$1"
}


current_branch () {
    git branch | grep \* | cut -d ' ' -f2
}


push () {
    git push origin -u $(current_branch)
}


rename () {
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


__rename_remote () {
    new_name="$1"
    old_name=$(current_branch)

    git branch -m $old_name $new_name
    git push origin --delete $old_name
    push
}


merge_diff () {
    if [ -z "$1" ]; then
        branch_to_compare="origin/master"
    else
        branch_to_compare="$1"
    fi

    git log $branch_to_compare..$(current_branch) --oneline | grep "Merge pull*"
}


datever () {
    date +%Y.%m.%d.%H%M
}

genpass () {
    openssl rand -base64 "$1"
}


import () {
    env_file="$1"

    while IFS='' read -r line || [ -n "${LINE}" ]; do
        if [ "$line" = "" ]; then
            continue
        fi

        export "$line"
    done < $env_file
}
