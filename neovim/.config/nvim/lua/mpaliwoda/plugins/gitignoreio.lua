return {
    "wintermute-cell/gitignore.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {},
    keys = {
        { "<leader>gi", "<cmd>lua require('gitgnore').generate()<cr>" }
    }
}
