return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects", lazy = true },
    },
    config = function()
        require("nvim-treesitter").setup()

        require("nvim-treesitter-textobjects").setup({
            swap = {
                enable = true,
                swap_next = {
                    ["<M-L>"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<M-H>"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]p"] = "@parameter.inner",
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[p"] = "@parameter.inner",
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["aF"] = "@function.outer",
                    ["iF"] = "@function.inner",
                    ["ac"] = "@conditional.outer",
                    ["ic"] = "@conditional.inner",
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["av"] = "@variable.outer",
                    ["iv"] = "@variable.inner",
                    ["iC"] = "@class.inner",
                    ["aC"] = "@class.outer",
                    ["il"] = "@loop.inner",
                    ["al"] = "@loop.outer",
                    ["af"] = "@call.outer",
                    ["if"] = "@call.inner",
                },
            },
        })
    end,
}
