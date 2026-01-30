return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
            { "sindrets/diffview.nvim", lazy = true },
        },
        cmd = "Neogit",
        keys = {
            { "<Leader>gg", function() require("neogit").open({ kind = "split" }) end, desc = "Neogit" },
            { "<Leader>gc", function() require("neogit").open({ "commit", kind = "split" }) end, desc = "Neogit commit" },
            { "<Leader>gl", function() require("neogit").open({ "log", kind = "split" }) end, desc = "Neogit log" },
            { "<Leader>gdi", function() require("neogit").open({ "diff" }) end, desc = "Neogit diff" },
            { "<Leader>gp", function() require("neogit").open({ "push" }) end, desc = "Neogit push" },
            { "<Leader>gs", function() require("neogit").open({ "stash" }) end, desc = "Neogit stash" },
            { "<Leader>gM", function() require("neogit").open({ "merge" }) end, desc = "Neogit merge" },
            { "<Leader>gw", function() require("mpaliwoda.utils.process").run("git", "add", vim.fn.expand("%")) end, desc = "Git add file" },
            { "<Leader>gW", function() require("mpaliwoda.utils.process").run("git", "add", vim.fn.expand("%"), "-f") end, desc = "Git add file (force)" },
        },
        opts = {},
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("gitsigns").setup({})
            vim.keymap.set("n", "<Leader>gb", "<cmd>Gitsigns blame<cr>")
        end,
    },
}
