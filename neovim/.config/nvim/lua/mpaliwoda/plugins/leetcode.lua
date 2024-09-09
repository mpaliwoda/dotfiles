local leet_arg = "leet"

return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-treesitter/nvim-treesitter",
        "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        lang = "python3",
        arg = leet_arg,
        image_support = true,
    },
    lazy = leet_arg ~= vim.fn.argv()[1],
}
