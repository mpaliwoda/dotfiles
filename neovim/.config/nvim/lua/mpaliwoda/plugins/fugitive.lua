return {
    "tpope/vim-fugitive",
    keys = {
        { "<Leader>gg",   "<cmd>G<cr>" },
        { "<Leader>gc",   "<cmd>Git commit<cr>" },
        { "<Leader>gl",   "<cmd>Git log<cr>" },
        { "<Leader>gb",   "<cmd>Git blame<cr>" },
        { "<Leader>gdi",  "<cmd>Gdiff<cr>" },
        { "<Leader>gdel", "<cmd>GRemove<cr>" },
        { "<Leader>gp",   "<cmd>Git push<cr>" },
        { "<Leader>gw",   "<cmd>Gwrite<cr>" },
        { "<Leader>gW",   "<cmd>Gwrite!<cr>" },
        { "<Leader>gh",   "<cmd>Telescope git_commits<cr>" },
        { "<Leader>gs",   "<cmd>Git stash<cr>" },
        { "<Leader>gS",   "<cmd>Telescope git_stash<cr>" },
        { "<Leader>gB",   "<cmd>Telescope git_branches<cr>" },
        { "<Leader>gM",   "<cmd>Git mergetool<cr>" },
    }
}
