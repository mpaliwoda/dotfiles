return {
    "nvim-pack/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
        { "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>" },
        { "<leader>sp", "<cmd>lua require('spectre').open_file_search()<cr>" },
        { "<leader>s", "<cmd>lua require('spectre').open_visual()<cr>" },
    },
}
