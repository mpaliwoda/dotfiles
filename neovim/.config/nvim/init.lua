vim.loader.enable()

require('plugins.plug')
require('settings')
require('global')
require('colorschemes.onedark')
require("plugins.notify")

vim.cmd('so ~/.config/nvim/autocmds.vim')
vim.cmd('so ~/.config/nvim/keymaps.vim')


require("plugins.silicon")
