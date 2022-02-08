require('plugins/vim-plug')
require('settings')

require('plugins/colorizer')
require('plugins/feline')
require('plugins/gitgutter')
require('plugins/goyo')
require('plugins/gutentags')
require('plugins/mundo')
require('plugins/nvim-autopairs')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/tabline')
require('plugins/telescope')

vim.cmd('colorscheme deus')
vim.cmd('so ~/.config/nvim/keymaps.vim')
vim.cmd('so ~/.config/nvim/autocmds.vim')

vim.g.node_client_debug = 1
