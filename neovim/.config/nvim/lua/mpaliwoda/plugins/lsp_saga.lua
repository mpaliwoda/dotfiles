return {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
        require("lspsaga").setup({
            code_action = {
                show_server_name = true,
                extend_gitsigns = true,
            },
            definition = {
                keys = {
                    edit = {"<C-e>", "o"},
                    vsplit = "<C-v>",
                    split = "<C-s>",
                    close = "<Esc>",
                }
            },
            rename = {
                keys = {
                    close = "<Esc>",
                }
            },
            finder = {
                layout = "normal",
                keys = {
                    edit = {"<C-e>", "o"},
                    close = "<Esc>",
                    vsplit = "<C-v>",
                    split = "<C-s>",
                }
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader><space>", "<cmd>Lspsaga code_action<cr>", { silent = true })

        vim.keymap.set("n", "<leader>mgd", "<cmd>Lspsaga goto_definition<cr>", { silent = true })
        vim.keymap.set("n", "<leader>mgp", "<cmd>Lspsaga peek_definition<cr>", { silent = true })
        vim.keymap.set("n", "<leader>mgs", "<cmd>Lspsaga finder<cr>", { silent = true })
        vim.keymap.set("n", "<leader>mgo", "<cmd>Lspsaga outline<cr>", { silent = true })

        vim.keymap.set("n", "<leader>ren", "<cmd>Lspsaga rename<cr>", { silent = true })

        vim.keymap.set("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true })
        vim.keymap.set("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true })

        vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>')
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
}
