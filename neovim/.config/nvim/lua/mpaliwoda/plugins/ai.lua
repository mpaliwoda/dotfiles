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
    opts = {
        provider = "ollama",
        vendors = {
            ollama = {
                __inherited_from = "openai",
                api_key_name = "",
                endpoint = "http://127.0.0.1:11434/v1",
                model = "qwen2.5-coder:7b-instruct",
            },
        },
    }
}
