return {
    "navarasu/onedark.nvim",
    config = function()
        local onedark = require('onedark')

        onedark.setup({
            -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
            style = 'darker',
            ending_tildes = true,
            code_style = {
                comments = 'italic',
                keywords = 'bold',
                functions = 'bold',
                strings = 'italic',
                variables = 'none'
            },
        })

        onedark.load()
    end,
}
