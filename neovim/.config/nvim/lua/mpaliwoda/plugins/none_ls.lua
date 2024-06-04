return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        opts = function()
            local fsharplint = {
                name = "FSharpLint",
                method = require("null-ls").methods.DIAGNOSTICS,
                filetypes = { "fsharp" },
                generator = require("null-ls").generator({
                    command = "dotnet-fsharplint",
                    args = { "lint", "--file-type=file", "$FILENAME" },
                    from_stderr = true,
                    format = "raw",
                    check_exit_code = function(code)
                        return code <= 1
                    end,
                    on_output = function(params, done)
                        local out = params.output

                        if not out then
                            done(nil)
                            return
                        end

                        local sanitized = out:gsub("==========.-==========\n?", "")
                        local diagnostics = {}

                        for raw_diagnostic in sanitized:gmatch("(.-)%-%-%-+\n") do
                            local m = {
                                raw_diagnostic:match(
                                    "(.-)\nError on line (%d+) starting at column (%d+)\n(.-\nSee.-%/(%w+%d+)%.html)"
                                )
                            }

                            table.insert(diagnostics, {
                                message = m[1] .. "\n" .. m[4],
                                row = m[2],
                                col = m[3],
                                code = m[5],
                                source = "FSharpLint",
                                filename = params.bufname,
                                severity = require("null-ls.helpers").diagnostics.severities.warning,
                            })
                        end

                        done(diagnostics)
                    end,
                }),
            }
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
                    fsharplint,
                }
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
            handlers = {}
        }
    },
}
