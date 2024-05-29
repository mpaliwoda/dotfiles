return {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
        'smoka7/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
        {
            mode = { 'v', 'n' },
            '<C-n>',
            '<cmd>MCunderCursor<cr>',
        },
        {
            mode = { 'v', 'n' },
            '<M-N>',
            '<cmd>MCstart<cr>',
        },
    },
}
