vim.opt.list = true

local present, indent_blankline = pcall(require, 'tabline')

if not present then
    return
end

indent_blankline.setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
