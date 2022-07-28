pcall(require, 'impatient')

require('plugins/vim-plug')
require('plugins/rocks')
require('settings')

require('colorscheme')

require('plugins.glow')
require('plugins.neogen')
require('plugins/coc')
require('plugins/colorizer')
require('plugins/comment')
require('plugins/dadbod')
require('plugins/dap')
require('plugins/filetype')
require('plugins/gitgutter')
require('plugins/hop')
require('plugins/indent-blankline')
require('plugins/lualine')
require('plugins/neoclip')
require('plugins/notify')
require('plugins/nvim-autopairs')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/octo')
require('plugins/regexplainer')
require('plugins/spectre')
require('plugins/surround')
require('plugins/telescope')
require('plugins/toggletasks')
require('plugins/undotree')
require('plugins/vimtest')
require('plugins/whichkey')

vim.cmd('so ~/.config/nvim/keymaps.vim')
vim.cmd('so ~/.config/nvim/autocmds.vim')
