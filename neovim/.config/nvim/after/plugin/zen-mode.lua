prequire("zen-mode", function(zen)
    local lualine_present, lualine = pcall(require, 'lualine')

    zen.setup({
        window = {
            width = 140,
            height = 1,
            options = {
                list = true,
                cursorline = true,
                signcolumn = "yes",
                number = true,
                relativenumber = true,
            },
        },
        plugins = {
            options = {
                ruler = false,
                showcmd = false,
            },
            gitsigns = {
                enabled = true,
            },
            kitty = {
                enabled = true,
                font = "+2"
            },
        },
        on_open = function(win)
            if lualine_present then
                lualine.hide()
            end
        end,
        on_close = function()
            if lualine_present then
                lualine.hide({ unhide = true })
            end
        end,
    })
end)
