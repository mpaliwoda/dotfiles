merge_diff() {
    if [ "$1" = "" ]; then
        branch_to_compare="origin/master"
    else
        branch_to_compare="$1"
    fi

    git log "$branch_to_compare..$(current-branch)" --oneline | grep "Merge pull*"
}

# shamelessly copied from https://polothy.github.io/post/2019-08-19-fzf-git-checkout/
fzf-git-branch() {
    git rev-parse HEAD >/dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
    grep -v HEAD |
    fzf --height 50% --ansi --no-multi --preview-window right:65% \
        --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
    sed "s/.* //"
}

ch() {
    git rev-parse HEAD >/dev/null 2>&1 || return

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
        git checkout --track "$branch"
    else
        git checkout "$branch"
    fi
}

__rename_remote() {
    new_name="$1"
    old_name=$(current_branch)

    git branch -m "$old_name" "$new_name"
    git push origin --delete "$old_name"
    push
}

rename() {
    case $1 in
        local)
            git branch -m "$(current_branch)" "$2"
            ;;
        remote)
            __rename_remote "$2"
            ;;
        *)
            printf "Usage:\\n\\trename local \\$BRANCH_NAME\\n\\trename remote \\$BRANCH_NAME\\n"
            ;;
    esac
}
