alias v=nvim
alias vi=nvim
alias vim=nvim

alias gtree='git log --graph --pretty=oneline --abbrev-commit'
alias untracked='git ls-files --others --exclude-standard'

alias ls='lsd'
alias grep='grep --color=auto'

alias l='ls -CF'
alias la='ls -1a'
alias ll='ls -alF'

alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"


py_clean () {
    __clean "(__pycache__|\.pyc|\.pyo$|.mypy_cache|.pytest_cache|.benchmarks)"
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


# shamelessly copied from https://polothy.github.io/post/2019-08-19-fzf-git-checkout/
fzf-git-branch () {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}


ch () {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}


docker-murder () {
    docker rm $(docker ps -a -q)
}
