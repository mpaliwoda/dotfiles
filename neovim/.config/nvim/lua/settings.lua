local set = vim.opt

vim.cmd('filetype plugin indent on')

set.hidden = true
set.wildmenu = true
set.wildmode = 'full'
set.wildignore = { '*.swp', '*.bak', '*.pyc', '*.class', '*/tmp', '*/__pycache__', '*/node_modules' }

set.laststatus = 1
set.showtabline = 0
set.showcmd = true
set.cmdheight = 1

set.cursorline = true

set.hlsearch = true
set.ignorecase = true
set.smartcase = true

set.backspace = { 'indent', 'eol', 'start' }
set.autoindent = true

set.ruler = true
set.confirm = true
set.visualbell = true

set.mouse = 'a'

set.scrolljump = 5
set.autoread = true

set.pastetoggle = '<F10>'

set.expandtab = true
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4

set.background = 'dark'
set.termguicolors = true

set.splitbelow = true
set.splitright = true

set.number = true
set.relativenumber = true

set.lazyredraw = false
set.ttyfast = true

set.timeout = true
set.timeoutlen = 400
set.updatetime = 400

set.undofile = true
set.undodir = { os.getenv("HOME") .. '/.config/nvim/undodir' }

set.signcolumn = "yes"

vim.g.python3_host_prog = '~/.pyenv/shims/python'
vim.g.did_load_filetypes = 1
vim.g.loaded_perl_provider = 0
