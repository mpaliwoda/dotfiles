local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- completion, linting, syntax highlighting
Plug ('neoclide/coc.nvim',               { branch = 'release' })
Plug ('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

-- file searching, tags
Plug ('nvim-telescope/telescope.nvim')
Plug ('jremmen/vim-ripgrep')
Plug ('ludovicchabant/vim-gutentags')
Plug ('skywind3000/gutentags_plus')

-- lua utils
Plug ('nvim-lua/plenary.nvim')

-- ui
Plug ('majutsushi/tagbar',               { on = 'TagbarToggle' })
Plug ('simnalamburt/vim-mundo',          { on = 'MundoToggle' })
Plug ('junegunn/goyo.vim',               { on = 'Goyo' })
Plug ('kyazdani42/nvim-tree.lua')
Plug ('vimlab/split-term.vim')
Plug ('seblj/nvim-tabline')
Plug ('feline-nvim/feline.nvim')
Plug ('junegunn/goyo.vim')

-- whitespace and commenting
Plug ('tpope/vim-commentary')
Plug ('tpope/vim-surround')
Plug ('windwp/nvim-autopairs')

-- git
Plug ('airblade/vim-gitgutter')
Plug ('rhysd/committia.vim')
Plug ('tpope/vim-fugitive')

-- themes
Plug ('ajmwagar/vim-deus')

-- visual hints
Plug ('kyazdani42/nvim-web-devicons')
Plug ('lewis6991/gitsigns.nvim')
Plug ('luochen1990/rainbow')
Plug ('machakann/vim-highlightedyank')
Plug ('thaerkh/vim-indentguides')
Plug ('norcalli/nvim-colorizer.lua')

vim.call('plug#end')