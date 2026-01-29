return {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "md", "rmd", "quarto", "Avante" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("markview").setup({
            markdown = {
                code_blocks = {
                    sign = false,
                },
            },
            markdown_inline = {
                checkboxes = {
                    ["-"] = {
                        hl = "MarkviewCheckboxPending",
                        text = "",
                    },
                    checked = {
                        hl = "MarkviewCheckboxChecked",
                        scope_hl = "MarkviewCheckboxStriked",
                        text = "",
                    },
                    enable = true,
                    o = {
                        hl = "MarkviewCheckboxCancelled",
                        text = "",
                    },
                    unchecked = {
                        hl = "MarkviewCheckboxUnchecked",
                        text = "",
                    },
                    ["~"] = {
                        hl = "MarkviewCheckboxProgress",
                        text = "",
                    },
                },
            },
            preview = {
                filetypes = { "markdown", "md", "rmd", "quarto", "Avante" },
            },
            experimental = {
                check_rtp_message = false
            },
        })

        require("markview.extras.checkboxes").setup({
            default = "X",
            remove_style = "disable",
            states = {
                { " ", "/", "X" },
                { "<", ">" },
                { "?", "!", "*" },
                { '"' },
                { "l", "b", "i" },
                { "S", "I" },
                { "p", "c" },
                { "f", "k", "w" },
                { "u", "d" }
            }
        })

        require("markview.extras.headings").setup();

        vim.keymap.set("n", "<Leader>cb", "<Cmd>Checkbox toggle<cr>", { silent = true })
        vim.keymap.set("n", "<Leader>h=", "<Cmd>Heading increase<cr>", { silent = true })
        vim.keymap.set("n", "<Leader>h-", "<Cmd>Heading decrease<cr>", { silent = true })
    end,
}
