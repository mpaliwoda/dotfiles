pcall(require, 'impatient')

require('plugins.plug')
require('plugins.rocks')
require('settings')
require('colorschemes.onedark')

vim.cmd('so ~/.config/nvim/autocmds.vim')
vim.cmd('so ~/.config/nvim/keymaps.vim')
