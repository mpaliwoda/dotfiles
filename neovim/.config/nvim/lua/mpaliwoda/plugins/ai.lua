return {
    "yetone/avante.nvim",
    event = "VeryLazy",
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
        provider = "gemini",
        providers = {
            gemini = {
                model = "gemini-2.5-flash-preview-05-20",
                extra_request_body = {
                    temperature = 0.5,
                    max_tokens = 8192 * 4,
                },
            },
            groq = {
                __inherited_from = "openai",
                api_key_name = "GROQ_API_KEY",
                endpoint = "https://api.groq.com/openai/v1/",
                model = "compound-beta-mini",
            },
            mistral = {
                __inherited_from = "openai",
                api_key_name = "MISTRAL_API_KEY",
                endpoint = "https://api.mistral.ai/v1/",
                model = "mistral-large-latest",
                extra_request_body = {
                    max_tokens = 4096,
                },
            },
        },
        disabled_tools = { "git_commit" },
        behaviour = {
            auto_suggestions = false,
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = false,
        },
    },
}
