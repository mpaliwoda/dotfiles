vim.cmd('filetype plugin indent on')

vim.opt.hidden = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'full'
vim.opt.wildignore = { '*.swp', '*.bak', '*.pyc', '*.class', '*/tmp', '*/__pycache__', '*/node_modules' }

vim.opt.laststatus = 1
vim.opt.showtabline = 1
vim.opt.showcmd = true
vim.opt.cmdheight = 1

vim.opt.cursorline = true

vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.autoindent = true

vim.opt.ruler = true
vim.opt.confirm = true
vim.opt.visualbell = true

vim.opt.mouse = 'a'

vim.opt.scrolljump = 5
vim.opt.autoread = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.background = 'dark'
vim.opt.termguicolors = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.lazyredraw = false
vim.opt.ttyfast = true

vim.opt.timeout = true
vim.opt.timeoutlen = 400
vim.opt.updatetime = 400

vim.opt.undofile = true
vim.opt.undodir = { os.getenv("HOME") .. '/.config/nvim/undodir' }
vim.opt.swapfile = false

vim.opt.signcolumn = "yes"

vim.g.mapleader = " "
