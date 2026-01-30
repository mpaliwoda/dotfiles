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
