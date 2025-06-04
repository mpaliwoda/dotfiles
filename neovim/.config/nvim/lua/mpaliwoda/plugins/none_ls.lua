return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        opts = function()
            return {
                sources = {
                    require("null-ls").builtins.diagnostics.mypy.with({
                        prefer_local = ".venv/bin",
                    }),
                    require("null-ls").builtins.diagnostics.djlint.with({
                        prefer_local = ".venv/bin",
                        filetypes = { "htmldjango", "jinja", "jinja.html", "j2" },
                    }),
                    require("null-ls").builtins.formatting.djlint.with({
                        prefer_local = ".venv/bin",
                        filetypes = { "htmldjango", "jinja", "jinja.html", "j2" },
                    }),
                    require("none-ls.diagnostics.ruff").with({
                        prefer_local = ".venv/bin",
                    }),
                    require("none-ls.formatting.ruff").with({
                        prefer_local = ".venv/bin",
                    }),
                    require("none-ls.formatting.ruff_format").with({
                        prefer_local = ".venv/bin",
                    }),
                },
            }
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = {
            automatic_installation = true,
            automatic_setup = true,
            ensure_installed = {},
            handlers = {},
        },
    },
}
