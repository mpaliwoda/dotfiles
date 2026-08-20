return {
    filetypes = { "html", "htmldjango", "jinja", "j2", "jinja.html" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = false,
    },
}
