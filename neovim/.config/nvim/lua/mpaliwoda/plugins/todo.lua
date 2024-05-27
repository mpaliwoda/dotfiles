return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("todo-comments").setup({})

        vim.keymap.set("n", "<leader>todo", "<cmd>TodoTelescope<cr>", { buffer = false, silent = true })
    end
}
