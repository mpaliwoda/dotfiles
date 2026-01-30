return {
    "kevinhwang91/nvim-hlslens",
    keys = {
        { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Next search" },
        { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Prev search" },
        { "*", [[*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word forward" },
        { "#", [[#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word backward" },
        { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search partial word forward" },
        { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search partial word backward" },
        { "<C-l>", "<Cmd>noh<CR>", desc = "Clear search highlight" },
    },
    opts = {},
}
