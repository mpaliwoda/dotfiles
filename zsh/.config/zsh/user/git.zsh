current_branch () {
    git branch --show-current
}

merge_diff() {
    if [ "$1" = "" ]; then
        branch_to_compare="origin/master"
    else
        branch_to_compare="$1"
    fi

    git log "$branch_to_compare..$(current_branch)" --oneline | grep "Merge pull*"
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
