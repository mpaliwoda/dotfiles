return {
    {
        "williamboman/mason.nvim",
        lazy = true,
        cmd = {
            "Mason",
            "MasonUpdate",
            "MasonInstall",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        },
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "b0o/schemastore.nvim",
        },
        event = { "VeryLazy" },
        opts = function(_plugin, _opts)
            local default_capabilities = vim.tbl_deep_extend("force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            return {
                ensure_installed = {},
                automatic_installation = true,
                handlers = {
                    -- default handler
                    function(server_name)
                        require("lspconfig")[server_name].setup({ capabilities = default_capabilities })
                    end,
                    ["html"] = function()
                        require("lspconfig").html.setup({
                            filetypes = { "html", "htmldjango", "jinja", "j2", "jinja.html" },
                            capabilities = default_capabilities,
                            init_options = {
                                configurationSection = { "html", "css", "javascript" },
                                embeddedLanguages = {
                                    css = true,
                                    javascript = true
                                },
                                provideFormatter = false,
                            }
                        })
                    end,
                    ["emmet_ls"] = function()
                        require("lspconfig").emmet_ls.setup({
                            filetypes = {
                                "astro",
                                "css",
                                "eruby",
                                "html",
                                "htmldjango",
                                "j2",
                                "javascript",
                                "javascriptreact",
                                "jinja",
                                "jinja.html",
                                "less",
                                "pug",
                                "sass",
                                "scss",
                                "svelte",
                                "typescriptreact",
                                "vue",
                            },
                            capabilities = default_capabilities,
                        })
                    end,
                    ["yamlls"] = function()
                        require("lspconfig").yamlls.setup({
                            settings = {
                                yaml = {
                                    schemaStore = {
                                        enable = false,
                                        url = "",
                                    },
                                    rules = {
                                        ['key-ordering'] = "disable"
                                    },
                                    schemas = require('schemastore').yaml.schemas(),
                                },
                            },
                        })
                    end,
                    ["basedpyright"] = function()
                        require("lspconfig").basedpyright.setup({
                            settings = {
                                basedpyright = {
                                    disableOrganizeImports = true,
                                    analysis = {
                                        typeCheckingMode = "off",
                                    }
                                },
                            },
                        })
                    end,
                    ["ts_ls"] = function()
                        require("lspconfig").ts_ls.setup({
                            settings = {
                                typescript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all",
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                },
                                javascript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all",
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                },
                            },
                        })
                    end,
                    ["gopls"] = function()
                        require("lspconfig").gopls.setup({
                            settings = {
                                gopls = {
                                    hints = {
                                        assignVariableTypes = true,
                                        compositeLiteralFields = true,
                                        compositeLiteralTypes = true,
                                        constantValues = true,
                                        functionTypeParameters = true,
                                        parameterNames = true,
                                        rangeVariableTypes = true,
                                    },
                                },
                            },
                        })
                    end,
                    ["jsonls"] = function()
                        require('lspconfig').jsonls.setup {
                            settings = {
                                json = {
                                    schemas = require('schemastore').json.schemas(),
                                    validate = { enable = true },
                                },
                            },
                        }
                    end,
                    ["bashls"] = function()
                        require("lspconfig").bashls.setup {
                            filetypes = { "sh", "bash" },
                            settings = {
                                bashIde = {
                                    globPattern = "*@(.sh|.inc|.bash|.command)",
                                    enableSourceErrorDiagnostics = true,
                                    includeAllWorkspaceSymbols = true,
                                    shellcheckPath = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/shellcheck",
                                    shfmt = {
                                        path = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/shfmt",
                                        caseIndent = true,
                                        simplifyCode = true,
                                        binaryNextLine = true,
                                    },
                                },
                            }
                        }
                    end,
                },
            }
        end
    }
}
