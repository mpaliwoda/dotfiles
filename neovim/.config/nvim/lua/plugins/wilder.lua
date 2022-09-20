local present, wilder = pcall(require, 'wilder')

if not present then
    return
end


wilder.setup({ modes = { ':', '/', '?' } })

wilder.set_option('use_python_remote_plugin', 0)

wilder.set_option('pipeline', {
    wilder.branch(
        wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
        }),
        wilder.vim_search_pipeline()
    )
})

local popupmenu_renderer = wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
        highlighter = wilder.lua_fzy_highlighter(),
        left = {
            ' ',
            wilder.popupmenu_devicons()
        },
        right = {
            ' ',
            wilder.popupmenu_scrollbar()
        },
        highlights = {
            border = 'Normal', -- highlight to use for the border
            accent = 'Normal',
            selected_accent = 'PmenuSelBold',
            default = "SignColumn"
        },
        border = 'rounded',
    })
)

wilder.set_option('renderer', wilder.renderer_mux({
    [':'] = popupmenu_renderer,
    ['/'] = wilder.wildmenu_renderer({
        highlighter = wilder.lua_fzy_highlighter(),
    }),
}))
