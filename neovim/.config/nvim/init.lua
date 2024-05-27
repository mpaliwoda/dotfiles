require("mpaliwoda.lazy")
require("mpaliwoda.settings")

require("lazy").setup({
    spec = "mpaliwoda.plugins",
    checker = {
        enabled = true,
        concurrency = 8,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    ui = {
        border = "rounded",
    }
})
