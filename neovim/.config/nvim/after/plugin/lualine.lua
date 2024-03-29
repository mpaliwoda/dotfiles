prequire("lualine", function(lualine)
    lualine.setup({
        options = {
            theme = 'auto',
            globalstatus = true
        },
        sections = {
            lualine_x = {
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
end)
