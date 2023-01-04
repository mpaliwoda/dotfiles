prequire("mason.settings", function(mason_settings)
    mason_settings.set({
        ui = {
            border = "rounded"
        }
    })
end)


prequire("lsp-zero", function(lsp)
    lsp.set_preferences({
        suggest_lsp_servers = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = false,
        configure_diagnostics = true,
        cmp_capabilities = true,
        manage_nvim_cmp = false,
        call_servers = 'local',
        sign_icons = {
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = ''
        }
    })

    lsp.ensure_installed({
        "bashls",
        "cssls",
        "dockerls",
        "emmet_ls",
        "eslint",
        "gopls",
        "html",
        "jdtls",
        "jsonls",
        "marksman",
        "pylsp",
        "ruby_ls",
        "rust_analyzer",
        "solargraph",
        "sqlls",
        "sumneko_lua",
        "tailwindcss",
        "terraformls",
        "tflint",
        "tsserver",
        "vimls",
        "yamlls",
    })

    lsp.configure("pylsp", {
        settings = {
            pylsp = {
                configurationSources = { "flake8" },
                plugins = {
                    autopep8 = { enabled = false },
                    mccabe = { enabled = false },
                    preload = { enabled = false },
                    pycodestyle = { enabled = false },
                    pydocstyle = { enabled = false },
                    pyflakes = { enabled = false },
                    pylint = { enabled = false },
                    yapf = { enabled = false },

                    flake8 = { enabled = true },
                    isort = { enabled = true },
                    jedi_completion = { enabled = true },
                    jedi_hover = { enabled = true },
                    jedi_references = { enabled = true },
                    jedi_signature_help = { enabled = true },
                    jedi_symbols = { enabled = true, all_scopes = true },
                    mypy = { enabled = true, live_mode = true },
                    rope_autoimport = { enabled = true },
                    rope_completion = { enabled = true },
                },
            },
        },
    })

    lsp.configure("solargraph", {
        init_options = { formatting = true },
        settings = {
            solargraph = {
                diagnostics = true
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

    lsp.configure("sumneko_lua", {
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
                    globals = { "vim", "prequire" }
                },
                runtime = {
                    version = "LuaJIT",
                    path = path
                },
                workspace = {
                    library = library,
                    maxPreload = 2000,
                    preloadFileSize = 50000
                },
                telemetry = { enable = false }
            },
        },
    })

    lsp.configure("tsserver", {
        settings = {
            typescript = {
                inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                }
            },
            avascript = {
                inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                }
            }
        }
    })

    lsp.configure("gopls", {
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

    lsp.on_attach(function(client, bufnr)
        local noremap = { buffer = bufnr, remap = false }

        local lenses = vim.lsp.codelens.get(bufnr)
        vim.lsp.codelens.display(lenses, bufnr, client)

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

        vim.keymap.set("n", "<leader>mgd", "<cmd>lua vim.lsp.buf.definition()<cr>", noremap)
        vim.keymap.set("n", "<leader>mgs", "<cmd>lua vim.lsp.buf.references()<cr>", noremap)
        vim.keymap.set("n", "<leader>mgi", "<cmd>lua vim.lsp.buf.implementation()<cr>", noremap)
        vim.keymap.set("n", "<leader>mgy", "<cmd>lua vim.lsp.buf.type_definition()<cr>", noremap)
        vim.keymap.set("n", "<leader>ren", "<cmd>lua vim.lsp.buf.rename()<cr>", noremap)

        vim.keymap.set("n", "<M-h>", "<cmd>lua vim.diagnostic.open_float()<cr>", noremap)
        vim.keymap.set("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>", noremap)
        vim.keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>", noremap)
        vim.keymap.set("n", "<M-d>", toggle_diagnostics())

        vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.codelens.run()<cr>", noremap)
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", noremap)
        vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", noremap)

        vim.keymap.set("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", noremap)
        vim.keymap.set("v", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", noremap)
    end)

    lsp.nvim_workspace()
    lsp.setup()

    vim.opt.completeopt = { 'menu', 'menuone' }

    prequire("cmp", function(cmp)
        local cmp_config = lsp.defaults.cmp_config({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            }
        })

        table.insert(cmp_config.sources, { name = "emoji" })
        table.insert(cmp_config.sources, { name = "emmet_vim" })

        local lspkind_present, lspkind = pcall(require, "lspkind")

        if lspkind_present then
            cmp_config["formatting"] = {
                format = lspkind.cmp_format({ mode = "symbol_text" })
            }
        end

        cmp.setup(cmp_config)
    end)

    prequire("telescope.builtin", function(t_builtin)
        vim.lsp.handlers["textDocument/references"] = t_builtin.lsp_references

        vim.keymap.set("n", "<leader>mgq", t_builtin.lsp_document_symbols)
        vim.keymap.set("n", "<leader>mgQ", t_builtin.lsp_workspace_symbols)
    end)

    vim.lsp.handlers["textDocument/hover"]         = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

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

    prequire("lsp_lines", function(lines)
        lines.setup()
        vim.keymap.set("n", "<M-g>", lines.toggle)
    end)

    vim.diagnostic.config({
        virtual_text = true,
        virtual_lines = { only_current_line = true }
    })
end)
