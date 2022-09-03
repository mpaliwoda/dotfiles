local present, treesitter = pcall(require, 'nvim-treesitter.configs')

if not present then
    return
end

treesitter.setup({
    ensure_installed = "all",
    ignore_install = { "phpdoc" },
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
                ["<M-l>"] = "@parameter.inner",
            },
            swap_previous = {
                ["<M-h>"] = "@parameter.inner",
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
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
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
            },
        },
    },
    -- section for nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
})

local context_ext_present, treesitter_context = pcall(require, 'treesitter-context')

if not context_ext_present then
    return
end


treesitter_context.setup({
    enable = true,
    max_lines = -1,
    mode = 'cursor',
})
