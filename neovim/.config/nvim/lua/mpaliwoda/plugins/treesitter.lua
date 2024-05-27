return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            sync_install = false,
            ensure_installed = {},
            modules = {},
            ignore_install = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            auto_install = true,
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<M-n>",
                    node_incremental = "<M-]>",
                    node_decremental = "<M-[>",
                },
            },
            textobjects = {
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
            },
        })
    end,
}
