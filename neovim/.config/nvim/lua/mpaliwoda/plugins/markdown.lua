return {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "md", "rmd", "quarto", "Avante" },
    dependencies = {
        { "nvim-treesitter/nvim-treesitter", lazy = true },
        { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    keys = {
        { "<Leader>cb", "<Cmd>Checkbox toggle<cr>", ft = "markdown", desc = "Toggle checkbox" },
        { "<Leader>h=", "<Cmd>Heading increase<cr>", ft = "markdown", desc = "Increase heading" },
        { "<Leader>h-", "<Cmd>Heading decrease<cr>", ft = "markdown", desc = "Decrease heading" },
    },
    config = function()
        require("markview").setup({
            markdown = {
                code_blocks = { sign = false },
            },
            markdown_inline = {
                checkboxes = {
                    enable = true,
                    ["-"] = { hl = "MarkviewCheckboxPending", text = "" },
                    checked = { hl = "MarkviewCheckboxChecked", scope_hl = "MarkviewCheckboxStriked", text = "" },
                    o = { hl = "MarkviewCheckboxCancelled", text = "" },
                    unchecked = { hl = "MarkviewCheckboxUnchecked", text = "" },
                    ["~"] = { hl = "MarkviewCheckboxProgress", text = "" },
                },
            },
            preview = { filetypes = { "markdown", "md", "rmd", "quarto", "Avante" } },
            experimental = { check_rtp_message = false },
        })
        require("markview.extras.checkboxes").setup({
            default = "X",
            remove_style = "disable",
            states = {
                { " ", "/", "X" }, { "<", ">" }, { "?", "!", "*" }, { '"' },
                { "l", "b", "i" }, { "S", "I" }, { "p", "c" }, { "f", "k", "w" }, { "u", "d" },
            },
        })
        require("markview.extras.headings").setup()
    end,
}
