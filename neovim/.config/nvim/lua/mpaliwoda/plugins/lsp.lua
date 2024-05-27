local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/neodev.nvim",

        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        "nvimtools/none-ls.nvim",
        "jay-babu/mason-null-ls.nvim",

        "hrsh7th/cmp-nvim-lsp",
        "b0o/schemastore.nvim",
    },
    config = function()
        local neodev = require("neodev")
        neodev.setup()

        local lspconfig = require("lspconfig")

        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local null_ls = require("null-ls")
        local mason_null_ls = require("mason-null-ls")

        mason.setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
        })

        local default_capabilities = cmp_nvim_lsp.default_capabilities()

        mason_lspconfig.setup({
            ensure_installed = {},
            automatic_installation = true,
            handlers = {
                -- default handler
                function(server_name)
                    require("lspconfig")[server_name].setup({ capabilities = default_capabilities })
                end,
                ["html"] = function()
                    local capabilities = vim.deepcopy(default_capabilities)
                    capabilities.textDocument.completion.completionItem.snippetSupport = true

                    require("lspconfig").html.setup({
                        filetypes = { "html", "htmldjango", "jinja", "j2", "jinja.html" },
                        capabilities = capabilities,
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
                ["solargraph"] = function()
                    require("lspconfig").solargraph.setup({
                        init_options = { formatting = true },
                        settings = {
                            solargraph = {
                                diagnostics = true,
                            },
                        },
                    })
                end,
                ["rust_analyzer"] = function()
                    require("lspconfig").rust_analyzer.setup({
                        settings = {
                            rust_analyzer = {
                                diagnostics = {
                                    disabled = { "inactive-code" },
                                },
                            },
                        },
                    })
                end,
                ["yamlls"] = function()
                    lspconfig.yamlls.setup({
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
                ["pyright"] = function()
                    require("lspconfig").pyright.setup({
                        settings = {
                            pyright = {
                                reportUndefinedVariable = "none",
                            },
                            python = {
                                analysis = {
                                    typeCheckingMode = "off",
                                },
                            },
                        },
                    })
                end,
                ["tsserver"] = function()
                    require("lspconfig").tsserver.setup({
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
                end
            },
        })


        lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig.util.default_config.capabilities,
            default_capabilities
        )

        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function()
                ---@alias KeymapMode "n" | "v" | "i"
                ---@alias MappingRHS string | fun(): nil
                ---@type fun(mode: KeymapMode, lhs: string, rhs: MappingRHS): nil
                local map = function(mode, lhs, rhs)
                    local opts = { buffer = true, remap = false }
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                map("n", "<leader>mgi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
                map("n", "<leader>mgy", "<cmd>lua vim.lsp.buf.type_definition()<cr>")

                map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
                map("n", "<M-h>", "<cmd>lua vim.diagnostic.open_float()<cr>")

                map("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>")
                map("v", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>")
            end
        })

        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }


        mason_null_ls.setup({
            ensure_installed = {},
            automatic_setup = true,
            handlers = {},
            automatic_installation = true,
        })

        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.mypy.with({ prefer_local = ".venv/bin" }),
                -- null_ls.builtins.diagnostics.ruff.with({ prefer_local = ".venv/bin" }),
                -- null_ls.builtins.formatting.ruff.with({ prefer_local = ".venv/bin" }),
                null_ls.builtins.diagnostics.djlint.with({
                    prefer_local = ".venv/bin",
                    filetypes = { "htmldjango", "jinja", "jinja.html", "j2" },
                }),
                null_ls.builtins.formatting.djlint.with({
                    prefer_local = ".venv/bin",
                    filetypes = { "htmldjango", "jinja", "jinja.html", "j2" },
                }),
            }
        })
    end,
}
