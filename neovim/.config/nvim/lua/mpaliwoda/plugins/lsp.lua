return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    init = function()
        vim.lsp.set_log_level("ERROR")

        local function toggle_diagnostics()
            local toggled = true

            local wrapped = function()
                if toggled then vim.diagnostic.hide() else vim.diagnostic.show() end
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

        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function()
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
                map("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>")
                map("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>")
                map("n", "<F2>", "<cmd>lua vim.lsp.codelens.run()<cr>")

                map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
                map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
                map("n", "<M-h>", "<cmd>lua vim.diagnostic.open_float()<cr>")
                map("n", "<M-d>", toggle_diagnostics())

                map("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>")
                map("v", "<leader>fmt", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>")
            end
        })

        vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    end,
    config = function ()
        require("lspconfig").gleam.setup({})
    end
}
