let mapleader="\<SPACE>"

filetype indent plugin on               " determine the type of the file based on its name
syntax on                               " syntax higlighting
set hidden                              " re-use window and switch from unsaved buffer without saving it first
set wildmenu                            " better command line completion
set wildmode=full                       " apparently ^up
set wildignore=*.swp,*.bak,*.pyc,*.class,*/tmp,*/src,*/__pycache__

set showcmd                             " show partial commands in the last line of the screen
set hlsearch                            " highlight searches

set ignorecase                          " ignore case in searches
set smartcase                           " unless there are any uppercase letters in search

set backspace=indent,eol,start          " allow backspacing over autoindent, line breaks and start of insert action
set autoindent                          " keep the same indent as the line you're currently on

set nostartofline                       " stop certain movements from always going to the first char of a line
set ruler                               " display the cursor poition on the last line of the screen or in the status line of a window

set confirm                             " instead of failing a command, raise a dialogue to ask if file should be saved
set visualbell                          " use visual bell instead of beeping when doing something wrong

set mouse=a                             " use mouse in all modes
set cmdheight=2                         " cmd window height to 2 lines, to avoid press enter to continue

set number                              " display line numbers
set relativenumber
set notimeout ttimeout ttimeoutlen=200  " quickly timeout on keycodes, don't time out on mappings
set pastetoggle=<F11>                   " paste/no-paste with F11 key

set cursorline
set ttyfast
set updatetime=100

set undodir=~/.vim/undodir
set undofile

set shiftwidth=4
set softtabstop=4
set expandtab

set splitbelow
set splitright

set nocursorcolumn
set scrolljump=5
set lazyredraw

set nobomb

" autoupdate on write
augroup myvimrc
    au!
    au BufWritePost *.vim so $MYVIMRC
augroup END

augroup vimrc
    autocmd!
    autocmd BufWinEnter,Syntax * syn sync minlines=500 maxlines=500
augroup END

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif

  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=utf-8,latin1
endif

au BufNewFile,BufRead *.js, *.html, *.css, *.rb, *.yml, *.yaml
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
