return {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
    keys = {
        { "<leader>undo", "<cmd>lua require('undotree').toggle()<cr>" },
    },
}
