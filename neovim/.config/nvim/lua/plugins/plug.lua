local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- LSP
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('VonHeikemen/lsp-zero.nvim')
Plug('jubnzv/virtual-types.nvim')
Plug('simrat39/symbols-outline.nvim')
Plug('lvimuser/lsp-inlayhints.nvim')
Plug('https://git.sr.ht/~whynothugo/lsp_lines.nvim')

-- Completion
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('saadparwaiz1/cmp_luasnip')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-nvim-lua')
Plug('b0o/schemastore.nvim')
Plug("onsails/lspkind.nvim")

-- Snippets
Plug('L3MON4D3/LuaSnip')
Plug('rafamadriz/friendly-snippets')

-- syntax highlighting
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nathom/filetype.nvim')
Plug('nvim-treesitter/nvim-treesitter-textobjects')
Plug('slim-template/vim-slim')
Plug('nvim-treesitter/nvim-treesitter-context')
Plug('chrisbra/csv.vim')
Plug('chr4/nginx.vim')

-- debugging
Plug('mfussenegger/nvim-dap')
Plug('rcarriga/nvim-dap-ui')
Plug('mfussenegger/nvim-dap-python')
Plug('theHamsta/nvim-dap-virtual-text')
Plug('michaelb/sniprun', { ['do'] = 'bash install.sh' })


-- file searching
Plug('nvim-telescope/telescope.nvim')
Plug('jremmen/vim-ripgrep')
Plug('windwp/nvim-spectre')
Plug('AckslD/nvim-neoclip.lua')
Plug('nvim-telescope/telescope-file-browser.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })

-- lua utils
Plug('nvim-lua/plenary.nvim')

-- ui
Plug('mbbill/undotree', { on = "UndotreeToggle" })
Plug('kyazdani42/nvim-tree.lua')
Plug("akinsho/toggleterm.nvim")
Plug('nvim-lualine/lualine.nvim')
Plug('rcarriga/nvim-notify')
Plug('stevearc/dressing.nvim')
Plug('gen740/SmoothCursor.nvim')
Plug('folke/noice.nvim')
Plug('folke/zen-mode.nvim')
Plug('eandrju/cellular-automaton.nvim')
Plug('theprimeagen/harpoon')
Plug('folke/trouble.nvim')

-- whitespace and commenting
Plug('numToStr/Comment.nvim')
Plug('kylechui/nvim-surround')
Plug('windwp/nvim-autopairs')
Plug('tpope/vim-sleuth')

-- git
Plug('airblade/vim-gitgutter')
Plug('rhysd/committia.vim')
Plug('tpope/vim-fugitive')
Plug('tveskag/nvim-blame-line')
Plug('sodapopcan/vim-twiggy')
Plug('rhysd/git-messenger.vim')
Plug('akinsho/git-conflict.nvim')

-- sql
Plug('tpope/vim-dadbod')
Plug('kristijanhusak/vim-dadbod-ui')

-- themes
Plug('navarasu/onedark.nvim')

-- visual hints
Plug('kyazdani42/nvim-web-devicons')
Plug('lewis6991/gitsigns.nvim')
Plug('machakann/vim-highlightedyank')
Plug('p00f/nvim-ts-rainbow')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('laytan/cloak.nvim')
Plug('folke/todo-comments.nvim')

-- additional markdown support
Plug('jghauser/follow-md-links.nvim')
Plug('ellisonleao/glow.nvim', { branch = 'main' })
Plug('lukas-reineke/headlines.nvim')

-- other utils
Plug('MunifTanjim/nui.nvim')
Plug('tami5/sqlite.lua')
Plug('lewis6991/impatient.nvim')
Plug('romgrk/fzy-lua-native')

-- tasks
Plug('jedrzejboczar/toggletasks.nvim')

-- docker
-- Plug('dgrbrady/nvim-docker')

-- motions
Plug('phaazon/hop.nvim')
Plug('mg979/vim-visual-multi')
-- rocks
Plug('theHamsta/nvim_rocks',
    { ['do'] = 'pip3 install --user hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua' })


vim.call('plug#end')
