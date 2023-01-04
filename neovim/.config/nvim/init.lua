pcall(require, 'impatient')

require('plugins.plug')
require("plugins.notify")
require('settings')
require('global')
require('colorschemes.onedark')

vim.cmd('so ~/.config/nvim/autocmds.vim')
vim.cmd('so ~/.config/nvim/keymaps.vim')
