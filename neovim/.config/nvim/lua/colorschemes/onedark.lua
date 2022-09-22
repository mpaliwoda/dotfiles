local present, onedark = pcall(require, 'onedark')

if not present then
    return
end

onedark.setup({
    style = 'deep', -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    term_colors = true,
    ending_tildes = true,

    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'bold',
        strings = 'italic',
        variables = 'none'
    },

    diagnostics = {
        background = false,
    }
})

onedark.load()
