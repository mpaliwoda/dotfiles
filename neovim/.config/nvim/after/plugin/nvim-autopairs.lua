prequire("nvim-autopairs", function(aupairs)
    aupairs.setup({
        map_cr = false,
        disable_filetype = { "TelescopePrompt", "vim" }
    })
end)
