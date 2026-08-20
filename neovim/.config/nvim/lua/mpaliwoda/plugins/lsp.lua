-- Per-server settings live in `after/lsp/<server>.lua`, which Nvim merges on top
-- of the defaults nvim-lspconfig ships in its own `lsp/<server>.lua`.
-- See `:h lsp-config-merge`.
local servers = {
    "bashls",
    "basedpyright",
    "cssls",
    "emmet_ls",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "tailwindcss",
    "ts_ls",
    "yamlls",
}

return {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/schemastore.nvim", "mason-org/mason-lspconfig.nvim" },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
        vim.lsp.log.set_level("ERROR")

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

        Snacks.toggle.diagnostics():map("<C-M-d>")

        Snacks.toggle({
            name = "Virtual Lines",
            get = function()
                return vim.diagnostic.config().virtual_lines ~= false
            end,
            set = function(state)
                vim.diagnostic.config({
                    virtual_text = not state,
                    virtual_lines = state,
                })
            end,
        }):map("<C-M-l>")

        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function(ev)
                local opts = { buffer = true, remap = false }
                vim.keymap.set("n", "<leader>mgd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                vim.keymap.set("n", "<leader>mgs", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                vim.keymap.set("n", "<leader>mgi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                vim.keymap.set("n", "<leader>mgt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                vim.keymap.set("n", "<leader>ren", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                vim.keymap.set("n", "[g", "<cmd>lua vim.diagnostic.jump({ count = -1, float = false })<cr>", opts)
                vim.keymap.set("n", "]g", "<cmd>lua vim.diagnostic.jump({ count = 1, float = false })<cr>", opts)
                vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)

                vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                vim.keymap.set("n", "<C-M-h>", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)

                vim.keymap.set("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)
                vim.keymap.set("v", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)

                -- Native `textDocument/documentColor` (replaces nvim-highlight-colors)
                vim.lsp.document_color.enable(true, { bufnr = ev.buf }, { style = "virtual" })
            end,
        })

        vim.opt.completeopt = { "menu", "menuone", "noselect" }

        vim.lsp.enable(servers)
    end,
}
