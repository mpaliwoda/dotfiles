skip_global_compinit=1
setopt noglobalrcs
setopt inc_append_history
setopt share_history
setopt hist_ignore_space

eval $(/opt/homebrew/bin/brew shellenv)

if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

TO_SOURCE=("$HOME/.secrets" "$HOME/.aliases" "$HOME/.airhelp_aliases")
for file in "${TO_SOURCE[@]}"; do
    [ -f $file ] && source $file
done
