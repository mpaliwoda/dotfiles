return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        { 'kkharji/sqlite.lua', module = 'sqlite' },
    },
    opts = {
        enable_persistent_history = true,
    },
    keys = {
        { "<leader>fy", "<cmd>Telescope neoclip<cr>" },
    },
}
