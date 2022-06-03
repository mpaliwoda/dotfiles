local g = vim.g

g.nvim_tree_refresh_wait = 1000


local present, ntree = pcall(require, 'nvim-tree')
if not present then
    return
end


ntree.setup {
    disable_netrw           = true,
    hijack_netrw            = true,
    open_on_setup           = false,
    ignore_ft_on_setup      = {},
    open_on_tab             = false,
    hijack_cursor           = false,
    update_cwd              = false,
    respect_buf_cwd         = false,
    create_in_closed_folder = true,
    actions                 = {
        open_file = {
            quit_on_open = false,
            window_picker = {
                enable = true,
                exclude = {
                    buftype = { 'terminal' }
                },
            }
        },
        change_dir = {
            global = true,
        }
    },
    diagnostics             = {
        enable = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        }
    },
    update_focused_file     = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open             = {
        cmd  = nil,
        args = {}
    },
    filters                 = {
        dotfiles = false,
        custom = {}
    },
    git                     = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view                    = {
        width = 35,
        height = 100,
        hide_root_folder = false,
        side = 'left',
        mappings = {
            custom_only = false,
            list = {
                { key = "v", action = "vsplit" },
                { key = "s", action = "split" },
            }
        },
        number = true,
        relativenumber = true,
        signcolumn = "yes"
    },
    trash                   = {
        cmd = "trash",
        require_confirm = true
    },
    renderer                = {
        indent_markers         = { enable = false },
        highlight_git          = true,
        highlight_opened_files = "all",
        root_folder_modifier   = ">>>",
        add_trailing           = false,
        group_empty            = false,
        icons                  = { padding = ' ', show = {
            git = true,
            folder = true,
            file = true,
            folder_arrow = true,
        } },
        special_files          = { ['README.md'] = 1, Makefile = 1, MAKEFILE = 1 }

    }
}
