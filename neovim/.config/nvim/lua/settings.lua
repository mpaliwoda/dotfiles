local set = vim.opt

vim.cmd('filetype plugin indent on')

set.hidden = true
set.wildmenu = true
set.wildmode = 'full'
set.wildignore = { '*.swp', '*.bak', '*.pyc', '*.class', '*/tmp', '*/__pycache__', '*/node_modules' }

set.laststatus = 1
set.showtabline = 1
set.showcmd = true
set.cmdheight = 2

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

set.shiftwidth = 4
set.softtabstop = 4
set.expandtab = true

set.background = 'dark'
set.termguicolors = true

set.splitbelow = true
set.splitright = true

set.number = true
set.relativenumber = true

set.lazyredraw = true
set.ttyfast = true

set.ttimeout = true
set.ttimeoutlen = 200
set.updatetime = 300

set.undofile = true
set.undodir = os.getenv("HOME") .. '/.config/nvim/undodir'

set.cscopetag = true
set.csto = 0
set.tags = { './tags', 'tags;/' }

vim.g.python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'
vim.g.did_load_filetypes = 1
