local present, autopairs = pcall(require, 'nvim-autopairs')

if not present then
    return
end

autopairs.setup({
    map_cr = false,
    disable_filetype = { "TelescopePrompt", "vim" }
})
