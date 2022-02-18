require('plugins/vim-plug')
require('settings')

require('plugins/colorizer')
require('plugins/gitgutter')
require('plugins/goyo')
require('plugins/gutentags')
require('plugins/hardline')
require('plugins/mundo')
require('plugins/nvim-autopairs')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/tabline')
require('plugins/telescope')

vim.cmd('so ~/.config/nvim/keymaps.vim')
vim.cmd('so ~/.config/nvim/autocmds.vim')

pcall(vim.cmd, 'colorscheme deus')
