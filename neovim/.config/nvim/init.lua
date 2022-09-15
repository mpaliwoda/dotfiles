pcall(require, 'impatient')

require('plugins/vim-plug')
require('plugins/rocks')
require('settings')

pcall(require, "colorschemes.zephyr")

require('plugins/cloak')
require('plugins/coc')
require('plugins/comment')
require('plugins/dadbod')
require('plugins/dap')
require('plugins/dressing')
require('plugins/filetype')
require('plugins/gitgutter')
require('plugins/glow')
require('plugins/hop')
require('plugins/indent-blankline')
require('plugins/lualine')
require('plugins/neoclip')
require('plugins/notify')
require('plugins/nvim-autopairs')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/spectre')
require('plugins/surround')
require('plugins/telescope')
require('plugins/toggletasks')
require('plugins/undotree')
require('plugins/visual-multi')

vim.cmd('so ~/.config/nvim/keymaps.vim')
vim.cmd('so ~/.config/nvim/autocmds.vim')
