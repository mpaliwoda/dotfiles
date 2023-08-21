local function toggle_diagnostics()
    local toggled = true

    local wrapped = function()
        if toggled then
            vim.diagnostic.hide()
        else
            vim.diagnostic.show()
        end

        toggled = not toggled
    end

    return wrapped
end

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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

prequire("mason", function(mason)
    mason.setup({
        config = {
            ui = {
                border = "rounded",
            },
        }
    })
end)

prequire("lspconfig", function(lspconfig)
    prequire("cmp_nvim_lsp", function(cmp_nvim_lsp)
        prequire("mason-lspconfig", function(mason_lspconfig)
            mason_lspconfig.setup({
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "dockerls",
                    "emmet_ls",
                    "eslint",
                    "gopls",
                    "html",
                    "jsonls",
                    "marksman",
                    "pylsp",
                    "ruby_ls",
                    "rust_analyzer",
                    "solargraph",
                    "sqlls",
                    "lua_ls",
                    "tailwindcss",
                    "terraformls",
                    "tflint",
                    "tsserver",
                    "vimls",
                    "yamlls",

                }
            })

            for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
                if server_name == "tailwindcss" then
                    lspconfig[server_name].setup({
                        filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure",
                            "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby",
                            "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf",
                            "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim",
                            "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript",
                            "jinja", "j2", "jinja.html",
                            "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte" },
                        capabilities = cmp_nvim_lsp.default_capabilities(),
                    })
                elseif server_name == "html" then
                    local capabilities = cmp_nvim_lsp.default_capabilities()
                    capabilities.textDocument.completion.completionItem.snippetSupport = true

                    lspconfig[server_name].setup({
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
                elseif server_name == "emmet_ls" then
                    lspconfig[server_name].setup({
                        filetypes = { "astro", "css", "eruby", "html", "htmldjango", "javascript", "javascriptreact",
                            "less", "pug", "sass", "scss", "svelte", "typescriptreact", "vue", "jinja", "j2",
                            "jinja.html" },
                        capabilities = cmp_nvim_lsp.default_capabilities(),
                    })
                else
                    lspconfig[server_name].setup({
                        capabilities = cmp_nvim_lsp.default_capabilities(),
                    })
                end
            end
        end)

        local lsp_defaults = lspconfig.util.default_config

        lsp_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lsp_defaults.capabilities,
            cmp_nvim_lsp.default_capabilities()
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

                map("n", "<leader>mgd", "<cmd>lua vim.lsp.buf.definition()<cr>")
                map("n", "<leader>mgs", "<cmd>lua vim.lsp.buf.references()<cr>")
                map("n", "<leader>mgi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
                map("n", "<leader>mgy", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
                map("n", "<leader>ren", "<cmd>lua vim.lsp.buf.rename()<cr>")

                map("n", "<M-h>", "<cmd>lua vim.diagnostic.open_float()<cr>")
                map("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>")
                map("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>")
                map("n", "<M-d>", toggle_diagnostics())

                map("n", "<F2>", "<cmd>lua vim.lsp.codelens.run()<cr>")
                map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
                map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

                map("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>")
                map("v", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>")
            end
        })

        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

        prequire("cmp", function(cmp)
            local select_opts = { behavior = cmp.SelectBehavior.Select }

            local cmp_config = {
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp', keyword_length = 1 },
                    { name = 'emoji' },
                    { name = 'emmet_vim' },
                    { name = 'buffer',   keyword_length = 3 },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                formatting = {},
                mapping = {
                    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
                    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
                    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
                    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        local col = vim.fn.col('.') - 1

                        if cmp.visible() then
                            cmp.select_next_item(select_opts)
                        elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                            fallback()
                        else
                            cmp.complete()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item(select_opts)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
            }

            prequire(
                "lspkind",
                function(lspkind)
                    cmp_config.formatting["format"] = lspkind.cmp_format({ mode = "symbol_text" })
                end,
                function(_)
                    cmp_config.formatting["fields"] = { "menu", "abbr", "kind" }
                end
            )

            prequire("luasnip", function(luasnip)
                cmp_config["snippet"] = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                }

                cmp_config.mapping["<C-f>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' })

                cmp_config.mapping['<C-b>'] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' })
            end)

            prequire("copilot", function(copilot)
                copilot.setup({
                    suggestion = {
                        auto_trigger = true,
                        keymap = {
                            accept = "<M-.>",
                            next = "<M-l>",
                            prev = "<M-h>",
                        },
                    },
                })
            end)

            prequire("tailwindcss-colorizer-cmp", function(tailwindcss_colorizer_cmp)
                cmp_config.formatting["format"] = tailwindcss_colorizer_cmp.formatter
            end)

            cmp.setup(cmp_config)
        end)
    end)

    lspconfig.pylsp.setup({
        settings = {
            pylsp = {
                configurationSources = {},
                plugins = {
                    autopep8 = { enabled = false },
                    mccabe = { enabled = false },
                    preload = { enabled = false },
                    pycodestyle = { enabled = false },
                    pydocstyle = { enabled = false },
                    pyflakes = { enabled = false },
                    pylint = { enabled = false },
                    yapf = { enabled = false },
                    flake8 = { enabled = false },
                    isort = { enabled = false },
                    mypy = { enabled = false },
                    jedi_completion = { enabled = true },
                    jedi_hover = { enabled = true },
                    jedi_references = { enabled = true },
                    jedi_signature_help = { enabled = true },
                    jedi_symbols = { enabled = true, all_scopes = true },
                    rope_autoimport = { enabled = true },
                    rope_completion = { enabled = true },
                },
            },
        },
    })

    lspconfig.solargraph.setup({
        init_options = { formatting = true },
        settings = {
            solargraph = {
                diagnostics = true,
            },
        },
    })

    lspconfig.rust_analyzer.setup({
        settings = {
            rust_analyzer = {
                diagnostics = {
                    disabled = { "inactive-code" },
                },
            },
        },
    })

    lspconfig.yamlls.setup({
        settings = {
            yaml = {
                rules = {
                    ['key-ordering'] = "disable"
                }
            }
        }
    })

    local library = {}

    local path = vim.split(package.path, ";", {})
    table.insert(path, "lua/?.lua")
    table.insert(path, "lua/?/init.lua")

    local function add(lib)
        for _, p in pairs(vim.fn.expand(lib, false, true)) do
            p = vim.loop.fs_realpath(p)
            library[p] = true
        end
    end

    add(os.getenv("VIMRUNTIME"))
    add(os.getenv("HOME") .. "/.config/nvim")

    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                completion = { callSnippet = "Both" },
                hint = {
                    enable = true,
                    paramName = "All",
                    paramType = "All",
                    arrayIndex = "Enable",
                },
                diagnostics = {
                    globals = { "vim", "prequire" },
                },
                runtime = {
                    version = "LuaJIT",
                    path = path,
                },
                workspace = {
                    library = library,
                    maxPreload = 2000,
                    preloadFileSize = 50000,
                },
                telemetry = { enable = false },
            },
        },
    })

    lspconfig.tsserver.setup({
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

    lspconfig.gopls.setup({
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

    prequire("lsp_lines", function(lines)
        lines.setup()
        vim.keymap.set("n", "<M-g>", lines.toggle)

        vim.diagnostic.config({
            virtual_text = true,
            virtual_lines = { only_current_line = true },
            severity_sort = true,
            float = {
                border = 'rounded',
                source = 'always',
            },
        })

        lines.toggle()
    end)
end)

prequire("telescope.builtin", function(t_builtin)
    vim.lsp.handlers["textDocument/references"] = t_builtin.lsp_references

    vim.keymap.set("n", "<leader>mgq", t_builtin.lsp_document_symbols)
    vim.keymap.set("n", "<leader>mgQ", t_builtin.lsp_workspace_symbols)
end)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

prequire("symbols-outline", function(symbols_outline)
    symbols_outline.setup()
    vim.keymap.set("n", "<M-k>", "<cmd>SymbolsOutline<cr>")
end)

prequire("lsp-inlayhints", function(hints)
    hints.setup()

    vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
    vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
            if not (args.data and args.data.client_id) then
                return
            end

            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            hints.on_attach(client, bufnr)
        end,
    })

    vim.keymap.set("n", "<M-f>", hints.toggle)
end)

prequire("mason-nvim-dap", function(mason_nvim_dap)
    mason_nvim_dap.setup({ automatic_setup = true })

    prequire("dap", function(dap)
        vim.fn.sign_define("DapBreakpoint", { text = "⬢", texthl = "Yellow", linehl = "", numhl = "Yellow" })
        vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Green", linehl = "ColorColumn", numhl = "Green" })
        vim.api.nvim_set_keymap("n", "<M-'>", '<Cm>lua require("dap.ui.widgets").hover()<CR>', { silent = true })

        -- DAP UI
        prequire("dapui", function(dap_ui)
            dap_ui.setup()

            -- open on dap startup
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dap_ui.open()
            end

            dap.listeners.before.event_terminated["dapui_config"] = function()
                dap_ui.close()
            end

            dap.listeners.before.event_exited["dapui_config"] = function()
                dap_ui.close()
            end
        end)
    end)

    -- DAP VIRTUALTEXT
    prequire("nvim-dap-virtual-text", function(dap_vtext)
        dap_vtext.setup()
    end)

    prequire("dap-python", function(dap_python)
        dap_python.test_runner = "pytest"
        dap_python.setup()
    end)
end)

prequire("mason-null-ls", function(mason_null_ls)
    mason_null_ls.setup({
        ensure_installed = {
            "black",
            "isort",
        },
        automatic_setup = true,
        handlers = {}
    })

    prequire("null-ls", function(null_ls)
        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.pyproject_flake8.with({
                    prefer_local = ".venv/bin"
                }),
                null_ls.builtins.diagnostics.mypy.with({
                    prefer_local = ".venv/bin"
                }),
                null_ls.builtins.diagnostics.ruff.with({
                    prefer_local = ".venv/bin"
                }),
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
    end)
end)
