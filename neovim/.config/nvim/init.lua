require("mpaliwoda.lazy")
require("mpaliwoda.settings")

require("lazy").setup({
    spec = "mpaliwoda.plugins",
    checker = {
        enabled = true,
        concurrency = 8,
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "rplugin",
                "tarPlugin",
                "tutor",
                "zipPlugin",
            },
        },
    },
    ui = {
        border = "none"
    },
})

-- Native 0.12 plugins
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nvim.difftool")
vim.keymap.set("n", "<leader>undo", "<cmd>Undotree<cr>")
