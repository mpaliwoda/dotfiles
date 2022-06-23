local present, lualine = pcall(require, 'lualine')

if not present then
    return
end

lualine.setup({
    options = {
        theme = 'onedark',
        globalstatus = true
    },
    tabline = {
        lualine_a = {
            {
                'tabs',
                mode = 2
            }
        },
        lualine_y = {
            {
                'filename',
                path = 3
            }
        }
    },
    extensions = {
        "fugitive",
        "nvim-dap-ui",
        "nvim-tree",
        "toggleterm",
    }
})
