local present, lualine = pcall(require, 'lualine')

if not present then
    return
end

lualine.setup({
    options = {
        theme = 'auto',
        globalstatus = true
    },
    sections = {
        lualine_x = {
            'g:coc_status',
            'encoding',
            'fileformat',
            'filetype',
        },
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
        'fugitive',
        'nvim-dap-ui',
        'nvim-tree',
        'toggleterm',
    }
})
