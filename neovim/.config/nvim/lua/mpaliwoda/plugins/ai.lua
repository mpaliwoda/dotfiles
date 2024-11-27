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
            provider = "gemini",
            auto_suggestions_provider = "gemini",
            vendors = {
                ollama = {
                    __inherited_from = "openai",
                    api_key_name = "",
                    endpoint = "http://127.0.0.1:11434/v1",
                    model = "qwen2.5-coder:7b-instruct",
                },
            },
        })

        vim.api.nvim_create_user_command("ToggleProvider", function()
            local current_provider = require("avante.config").provider

            local toggle_to
            if current_provider == "ollama" then
                toggle_to = "gemini"
            else
                toggle_to = "ollama"
            end

            require("avante.config").override({
                provider = toggle_to,
                auto_suggestions_provider = toggle_to,
            })

            vim.notify("Toggled Avante to use: " .. toggle_to)
        end, {})
    end
}
