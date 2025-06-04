return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
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
    },
}
