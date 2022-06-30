pcall(require, 'impatient')

require('plugins/vim-plug')
require('settings')

require('colorscheme')

require('plugins/coc')
require('plugins/colorizer')
require('plugins/comment')
require('plugins/dap')
require('plugins/filetype')
require('plugins/gitgutter')
require('plugins/indent-blankline')
require('plugins/lualine')
require('plugins/luasnip')
require('plugins/mundo')
require('plugins/neoclip')
require('plugins/nvim-autopairs')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/octo')
require('plugins/regexplainer')
require('plugins/spectre')
require('plugins/telescope')
require('plugins/toggletasks')
require('plugins/vimtest')
require('plugins/whichkey')

vim.cmd('so ~/.config/nvim/keymaps.vim')
vim.cmd('so ~/.config/nvim/autocmds.vim')
