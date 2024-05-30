return {
    "wintermute-cell/gitignore.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
        local gitignore = require("gitignore")

        vim.keymap.set("n", "<leader>gi", gitignore.generate)
    end,
}
