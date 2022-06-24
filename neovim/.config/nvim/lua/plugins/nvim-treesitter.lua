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
            init_selection = "<C-n>",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
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
        keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["av"] = "@variable.outer",
            ["iv"] = "@variable.inner",
        },
    },
    -- section for nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
})
