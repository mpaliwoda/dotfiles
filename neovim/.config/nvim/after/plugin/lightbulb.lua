prequire("nvim-lightbulb", function(lightbulb)
    lightbulb.setup({
        sign = { enabled = true, priority = 100 },
        autocmd = { enabled = true },
    })
end)
