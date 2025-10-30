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
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    ui = {
        border = "none"
    },
})
