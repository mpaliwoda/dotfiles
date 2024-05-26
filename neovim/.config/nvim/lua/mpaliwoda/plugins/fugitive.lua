return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<Leader>gg", "<cmd>G<cr>")
        vim.keymap.set("n", "<Leader>gc", "<cmd>Git commit<cr>")
        vim.keymap.set("n", "<Leader>gl", "<cmd>Git log<cr>")
        vim.keymap.set("n", "<Leader>gb", "<cmd>Git blame<cr>")
        vim.keymap.set("n", "<Leader>gdi", "<cmd>Gdiff<cr>")
        vim.keymap.set("n", "<Leader>gdel", "<cmd>GRemove<cr>")
        vim.keymap.set("n", "<Leader>gp", "<cmd>Git push<cr>")
        vim.keymap.set("n", "<Leader>gw", "<cmd>Gwrite<cr>")
        vim.keymap.set("n", "<Leader>gW", "<cmd>Gwrite!<cr>")
        vim.keymap.set("n", "<Leader>gh", "<cmd>Telescope git_commits<cr>")
        vim.keymap.set("n", "<Leader>gs", "<cmd>Git stash<cr>")
        vim.keymap.set("n", "<Leader>gS", "<cmd>Telescope git_stash<cr>")
        vim.keymap.set("n", "<Leader>gB", "<cmd>Telescope git_branches<cr>")
        vim.keymap.set("n", "<Leader>gM", "<cmd>Git mergetool<cr>")
    end
}
