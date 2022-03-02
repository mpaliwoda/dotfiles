local present, scheme = pcall(require, 'onedark')

if not present then
    return
end

scheme.setup {
    style = 'darker', -- Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    term_colors = true,
    ending_tildes = true,

    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'bold',
        strings = 'italic',
        variables = 'none'
    },
}

scheme.load()
