return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("avante_lib").load()
        require("avante").setup({
            provider = "claude",
            auto_suggestions_provider = "claude",
            claude = {
                endpoint = "https://api.anthropic.com",
                model = "claude-3-5-sonnet-20241022",
                max_tokens = 4096,
            },
            behaviour = {
                auto_suggestions = false,
                auto_set_highlight_group = true,
                auto_set_keymaps = true,
                auto_apply_diff_after_generation = false,
                support_paste_from_clipboard = false,
                minimize_diff = false,
            },
        })
    end
}
