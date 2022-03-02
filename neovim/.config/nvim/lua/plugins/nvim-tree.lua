local g = vim.g

g.nvim_tree_indent_markers = 0
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_root_folder_modifier = '>>>'
g.nvim_tree_add_trailing = 0
g.nvim_tree_group_empty = 1
g.nvim_tree_icon_padding = ' '
g.nvim_tree_respect_buf_cwd = 0
g.nvim_tree_create_in_closed_folder = 1
g.nvim_tree_refresh_wait = 1000

g.nvim_tree_special_files = { ['README.md'] = 1, Makefile = 1, MAKEFILE = 1 }
g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 0,
}


local present, ntree = pcall(require, 'nvim-tree')
if not present then
    return
end


ntree.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = false,
    auto_open = false,
  },
  actions = {
    open_file = {
        quit_on_open = false,
        window_picker = {
            enable = true,
            exclude = {
                buftype = {'terminal'}
            },
        }
    },
    change_dir = {
        global = true,
    }
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 35,
    height = 100,
    hide_root_folder = false,
    side = 'left',
    auto_resize = true,
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
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}
