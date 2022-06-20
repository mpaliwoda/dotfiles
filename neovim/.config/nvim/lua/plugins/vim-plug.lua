local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- completion, linting, syntax highlighting
Plug ('neoclide/coc.nvim',               { branch = 'release' })
Plug ('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug ('nathom/filetype.nvim')
Plug ('fannheyward/telescope-coc.nvim')
Plug ('bennypowers/nvim-regexplainer')
Plug ('L3MON4D3/LuaSnip')
Plug ('rafamadriz/friendly-snippets')

-- debugging
Plug ('mfussenegger/nvim-dap')
Plug ('rcarriga/nvim-dap-ui')
Plug ('mfussenegger/nvim-dap-python')
Plug ('theHamsta/nvim-dap-virtual-text')
Plug ('vim-test/vim-test')

-- file searching, tags
Plug ('nvim-telescope/telescope.nvim')
Plug ('jremmen/vim-ripgrep')
Plug ('ludovicchabant/vim-gutentags')
Plug ('skywind3000/gutentags_plus')
Plug ('windwp/nvim-spectre')
Plug ('AckslD/nvim-neoclip.lua')

-- lua utils
Plug ('nvim-lua/plenary.nvim')

-- ui
Plug ('majutsushi/tagbar',               { on = 'TagbarToggle' })
Plug ('simnalamburt/vim-mundo',          { on = 'MundoToggle' })
Plug ('kyazdani42/nvim-tree.lua')
Plug ('seblj/nvim-tabline')
Plug ('ojroques/nvim-hardline')
Plug ('folke/which-key.nvim')
Plug ('pwntester/octo.nvim')
Plug ("akinsho/toggleterm.nvim",         { tag = "v1.*"} )

-- whitespace and commenting
Plug ('numToStr/Comment.nvim')
Plug ('tpope/vim-surround')
Plug ('windwp/nvim-autopairs')

-- git
Plug ('airblade/vim-gitgutter')
Plug ('rhysd/committia.vim')
Plug ('tpope/vim-fugitive')

-- themes
Plug ('navarasu/onedark.nvim')

-- visual hints
Plug ('kyazdani42/nvim-web-devicons')
Plug ('lewis6991/gitsigns.nvim')
Plug ('machakann/vim-highlightedyank')
Plug ('norcalli/nvim-colorizer.lua')
Plug ('p00f/nvim-ts-rainbow')
Plug ('lukas-reineke/indent-blankline.nvim')

-- additional motions
Plug ('AndrewRadev/splitjoin.vim')

-- additional markdown support
Plug ('jghauser/follow-md-links.nvim')
Plug ('ellisonleao/glow.nvim', { branch = 'main' })

-- other utils
Plug ('MunifTanjim/nui.nvim')
Plug ('tami5/sqlite.lua')
Plug ('lewis6991/impatient.nvim')

vim.call('plug#end')
