return {
    "wintermute-cell/gitignore.nvim",
    event = "VeryLazy",
    config = function()
        local gitignore = require("gitignore")

        vim.keymap.set("n", "<leader>gi", gitignore.generate)
    end,
}
