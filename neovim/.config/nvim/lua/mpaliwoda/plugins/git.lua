return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            local neogit = require("neogit")
            local process = require("mpaliwoda.utils.process")

            neogit.setup({})

            vim.keymap.set("n", "<Leader>gg", function()
                neogit.open({ kind = "split" })
            end)
            vim.keymap.set("n", "<Leader>gc", function()
                neogit.open({ "commit", kind = "split" })
            end)
            vim.keymap.set("n", "<Leader>gl", function()
                neogit.open({ "log", kind = "split" })
            end)
            vim.keymap.set("n", "<Leader>gdi", function()
                neogit.open({ "diff" })
            end)
            vim.keymap.set("n", "<Leader>gp", function()
                neogit.open({ "push" })
            end)
            vim.keymap.set("n", "<Leader>gs", function()
                neogit.open({ "stash" })
            end)
            vim.keymap.set("n", "<Leader>gM", function()
                neogit.open({ "merge" })
            end)
            vim.keymap.set("n", "<Leader>gw", function()
                local filename = vim.fn.expand("%")
                process.run("git", "add", filename)
            end)
            vim.keymap.set("n", "<Leader>gW", function()
                local filename = vim.fn.expand("%")
                process.run("git", "add", filename, "-f")
            end)
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({})
            vim.keymap.set("n", "<Leader>gb", "<cmd>Gitsigns blame<cr>")
        end,
    },
}
