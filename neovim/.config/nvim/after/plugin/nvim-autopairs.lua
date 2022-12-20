local present, autopairs = pcall(require, 'nvim-autopairs')

if not present then
    return
end

local remap = vim.api.nvim_set_keymap

autopairs.setup({
    map_cr = false,
    disable_filetype = { "TelescopePrompt", "vim" }
})

_G.MUtils = {}

MUtils.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0 then
        return vim.fn["coc#_select_confirm"]()
    else
        return autopairs.autopairs_cr()
    end
end

remap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', { expr = true, noremap = true })
