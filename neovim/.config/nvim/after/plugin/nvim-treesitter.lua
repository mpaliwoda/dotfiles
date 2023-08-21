prequire("nvim-treesitter.configs", function(treesitter)
    treesitter.setup({
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
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

    prequire("treesitter-context", function(treesitter_context)
        treesitter_context.setup({
            enable = true,
            max_lines = -1,
            mode = 'cursor',
        })
    end)
end)

prequire('rainbow-delimiters', function(rainbow_delimiters)
    vim.g.rainbow_delimiters = {
        strategy = {
            [''] = rainbow_delimiters.strategy['global'],
            vim = rainbow_delimiters.strategy['local'],
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        },
    }
end)
