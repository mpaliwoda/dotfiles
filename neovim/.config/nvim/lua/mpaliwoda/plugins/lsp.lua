return {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/schemastore.nvim", "mason-org/mason-lspconfig.nvim" },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
        local toggles = require("mpaliwoda.utils.toggles")

        vim.lsp.set_log_level("ERROR")

        vim.diagnostic.config({
            underline = false,
            virtual_text = true,
            virtual_lines = false,
            update_in_insert = false,
            severity_sort = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "✘",
                    [vim.diagnostic.severity.WARN] = "▲",
                    [vim.diagnostic.severity.HINT] = "⚑",
                    [vim.diagnostic.severity.INFO] = "",
                },
            },
        })

        toggles.create({
            name = "diagnostics",
            active = true,
            keybinds = { n = "<C-M-d>" },
            toggled = vim.diagnostic.show,
            untoggled = vim.diagnostic.hide,
        })

        toggles.create({
            name = "virtual_lines",
            active = true,
            keybinds = { n = "<C-M-l>" },
            toggled = function()
                vim.diagnostic.config({
                    virtual_text = true,
                    virtual_lines = false,
                })
            end,
            untoggled = function()
                vim.diagnostic.config({
                    virtual_text = false,
                    virtual_lines = true,
                })
            end,
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function()
                local opts = { buffer = true, remap = false }
                vim.keymap.set("n", "<leader>mgd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                vim.keymap.set("n", "<leader>mgs", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                vim.keymap.set("n", "<leader>mgi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                vim.keymap.set("n", "<leader>mgt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                vim.keymap.set("n", "<leader>ren", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                vim.keymap.set("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>", opts)
                vim.keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>", opts)
                vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)

                vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                vim.keymap.set("n", "<C-M-h>", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)

                vim.keymap.set("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)
                vim.keymap.set("v", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)
            end,
        })

        vim.opt.completeopt = { "menu", "menuone", "noselect" }

        vim.lsp.config("html", {
            filetypes = { "html", "htmldjango", "jinja", "j2", "jinja.html" },
            init_options = {
                configurationSection = { "html", "css", "javascript" },
                embeddedLanguages = {
                    css = true,
                    javascript = true,
                },
                provideFormatter = false,
            },
        })

        vim.lsp.config("emmet_ls", {
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
        })

        vim.lsp.config("yamlls", {
            settings = {
                yaml = {
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    rules = {
                        ["key-ordering"] = "disable",
                    },
                    schemas = require("schemastore").yaml.schemas(),
                },
            },
        })

        vim.lsp.config("basedpyright", {
            settings = {
                basedpyright = {
                    disableOrganizeImports = true,
                    analysis = {
                        typeCheckingMode = "off",
                        inlayHints = {
                            genericTypes = true,
                        },
                    },
                },
            },
        })

        vim.lsp.config("ts_ls", {
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

        vim.lsp.config("gopls", {
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

        vim.lsp.config("jsonls", {
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })

        vim.lsp.config("bashls", {
            filetypes = { "sh", "bash", "zsh" },
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
            },
        })

        vim.lsp.config("gleam", {})

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME,
                        },
                    },
                },
            },
        })

        vim.lsp.enable({ "gleam" })
    end,
}
