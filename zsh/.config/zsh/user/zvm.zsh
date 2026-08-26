# zsh-vi-mode rebinds the keymap on init, so anything that installs widgets
# (fzf, atuin) has to be sourced after it or its bindings are lost.
zvm_after_init ()
{
    source <(fzf --zsh)
    enable-fzf-tab
    eval "$(atuin init zsh)"
}
