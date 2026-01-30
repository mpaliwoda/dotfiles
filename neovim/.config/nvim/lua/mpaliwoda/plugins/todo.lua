return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("todo-comments").setup({})

        vim.keymap.set("n", "<leader>todo", "<cmd>TodoQuickFix<cr>", { buffer = false, silent = true })
    end,
}
