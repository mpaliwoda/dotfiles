local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

-- LSP
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('jubnzv/virtual-types.nvim')
Plug('lvimuser/lsp-inlayhints.nvim')
Plug('https://git.sr.ht/~whynothugo/lsp_lines.nvim')
Plug('jose-elias-alvarez/null-ls.nvim')
Plug 'jay-babu/mason-null-ls.nvim'
Plug('roobert/tailwindcss-colorizer-cmp.nvim')

-- Completion
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('saadparwaiz1/cmp_luasnip')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-nvim-lua')
Plug('b0o/schemastore.nvim')
Plug("onsails/lspkind.nvim")
Plug('hrsh7th/cmp-emoji')
Plug('mattn/emmet-vim')
Plug('dcampos/cmp-emmet-vim')
Plug('zbirenbaum/copilot.lua')

-- Snippets
Plug('L3MON4D3/LuaSnip')
Plug('rafamadriz/friendly-snippets')

-- syntax highlighting
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSInstall all' })
-- Plug('nathom/filetype.nvim')
Plug('nvim-treesitter/nvim-treesitter-textobjects')
Plug('nvim-treesitter/nvim-treesitter-context')
Plug('chrisbra/csv.vim')
Plug('chr4/nginx.vim')
Plug('Glench/Vim-Jinja2-Syntax')
-- Plug('adelarsq/neofsharp.vim')
Plug('ionide/Ionide-vim')

-- file searching
Plug('nvim-telescope/telescope.nvim')
Plug('jremmen/vim-ripgrep')
Plug('windwp/nvim-spectre')
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
Plug('folke/trouble.nvim')

-- whitespace and commenting
Plug('numToStr/Comment.nvim')
Plug('kylechui/nvim-surround')
Plug('windwp/nvim-autopairs')

-- git
Plug('rhysd/committia.vim')
Plug('tpope/vim-fugitive')
Plug('akinsho/git-conflict.nvim')

-- themes
Plug('navarasu/onedark.nvim')

-- visual hints
Plug('kyazdani42/nvim-web-devicons')
Plug('lewis6991/gitsigns.nvim')
Plug('machakann/vim-highlightedyank')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('laytan/cloak.nvim')
Plug('folke/todo-comments.nvim')
Plug('https://gitlab.com/HiPhish/rainbow-delimiters.nvim')

-- additional markdown support
Plug('jghauser/follow-md-links.nvim')
Plug('lukas-reineke/headlines.nvim')

-- other utils
Plug('MunifTanjim/nui.nvim')
Plug('tami5/sqlite.lua')
Plug('romgrk/fzy-lua-native')
Plug('0oAstro/silicon.lua')
Plug("linux-cultist/venv-selector.nvim/")

-- motions
Plug('phaazon/hop.nvim')
Plug('mg979/vim-visual-multi')
-- rocks
Plug('theHamsta/nvim_rocks',
    { ['do'] = 'pip3 install --user hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua' })

vim.call('plug#end')
