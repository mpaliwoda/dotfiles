local present, ntree = pcall(require, 'nvim-tree')

if not present then
    return
end

ntree.setup({
    disable_netrw           = true,
    hijack_netrw            = true,
    update_cwd              = true,
    actions                 = {
        change_dir = {
            global = true,
        }
    },
    diagnostics             = {
        enable = true,
    },
    view                    = {
        width = 35,
        mappings = {
            list = {
                { key = "v", action = "vsplit" },
                { key = "s", action = "split" },
            }
        },
        number = true,
        relativenumber = true,
    },
    trash                   = {
        cmd = "trash",
    },
    renderer                = {
        indent_markers         = { enable = true },
        highlight_git          = true,
        highlight_opened_files = "name",
        root_folder_modifier   = ">>>",
    }
})
