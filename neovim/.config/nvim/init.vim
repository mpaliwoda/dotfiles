set nocompatible                        " no vi mode

" Required:
set runtimepath+=~/.dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.dein')
    call dein#begin('~/.dein')

    " Let dein manage dein
    " Required:
    call dein#add('~/.dein/repos/github.com/Shougo/dein.vim')

    " python specific
    call dein#add('ambv/black')
    call dein#add('python-mode/python-mode')

    " other langs or general
    call dein#add('hashivim/vim-terraform')
    call dein#add('w0rp/ale')                       " linting and stuff
    " call dein#add('ajh17/VimCompletesMe')           " completion

    " editing stuff
    call dein#add('luochen1990/rainbow')            " matching parenthesis using colors
    call dein#add('ntpeters/vim-better-whitespace')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-surround')

    " git
    call dein#add('rhysd/committia.vim')            " fancy commit msg editing
    call dein#add('tpope/vim-fugitive')             " all the :G commands
    call dein#add('airblade/vim-gitgutter.git')     " shows changes in the file in column next to line no
    call dein#add('Xuyuanp/nerdtree-git-plugin')

    " ui
    call dein#add('nightsense/stellarized')         " coloscheme
    call dein#add('RRethy/vim-illuminate.git')      " highlights all occurrences of word under cursor
    call dein#add('machakann/vim-highlightedyank')  " highlights what was yanked
    call dein#add('scrooloose/nerdtree')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('ryanoasis/vim-devicons')
    "
    " misc
    call dein#add('sjl/gundo.vim')                  " shows undo tree
    call dein#add('francoiscabrol/ranger.vim')      " run ranger in vim
    call dein#add('vimlab/split-term.vim')          " :10Term and stuff
    call dein#add('wincent/command-t')              " fuzzy file searching
    call dein#add('osyo-manga/vim-precious')        " for context filetype
    call dein#add('Shougo/context_filetype.vim')    " ^^
    call dein#add('junegunn/vim-emoji')             " yay, emojis
    call dein#add('junegunn/goyo.vim')              " distraction free mode

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


let mapleader="\<SPACE>"


filetype indent plugin on               " determine the type of the file based on its name
syntax on                               " syntax higlighting
set hidden                              " re-use window and switch from unsaved buffer without saving it first
set wildmenu                            " better command line completion
set wildmode=full                       " apparently ^up
set wildignore=*.swp,*.bak,*.pyc,*.class,*/jellybeansvendored,*/tmp,*/src,*/__pycache__

set showcmd                             " show partial commands in the last line of the screen
set hlsearch                            " highlight searches

set ignorecase                          " ignore case in searches
set smartcase                           " unless there are any uppercase letters in search

set backspace=indent,eol,start          " allow backspacing over autoindent, line breaks and start of insert action
set autoindent                          " keep the same indent as the line you're currently on

set nostartofline                       " stop certain movements from always going to the first char of a line
set ruler                               " display the cursor poition on the last line of the screen or in the status line of a window

set laststatus=1                        " ~always display the status line, even if only one window is displayed~ // no longer valid

set confirm                             " instead of failing a command, raise a dialogue to ask if file should be saved
set visualbell                          " use visual bell instead of beeping when doing something wrong

" set t_vb=                             " reset terminal code for the visual bell

set mouse=a                             " use mouse in all modes
set cmdheight=2                         " cmd window height to 2 lines, to avoid press enter to continue

set number                              " display line numbers
set relativenumber                      " relative line numbers without extension :O?
set notimeout ttimeout ttimeoutlen=200  " quickly timeout on keycodes, don't time out on mappings
set pastetoggle=<F11>                   " paste/no-paste with F11 key

set cursorline
set ttyfast
set spell spelllang=en_us
set updatetime=100

" ~~~~~~~~~~~ UNDO
set undodir=~/.vim/undodir
set undofile

" ~~~~~~~~~~~ INDENTATION
set shiftwidth=4
set softtabstop=4
set expandtab

" ~~~~~~~~~~~ SPLITS
set splitbelow
set splitright

" ~~~~~~~~~~~ AUTOUPDATE VIM CONF
augroup myvimrc
    au!
    au BufWritePost ~/.config/nvim/init.vim so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" ~~~~~~~~~~~ Colorscheme
set background=dark
set termguicolors
colorscheme stellarized
"
" ~~~~~~~~~~~ VIM AIRLINE
let g:airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1

" ~~~~~~~~~~~ PYTHON EXECS
let g:python3_host_prog='~/.pyenv/versions/neovim3/bin/python'

" ~~~~~~~~~~~ NERDTREE
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']
let g:NERDTreeMinimalUI=0
let g:NERDTreeUpdateOnWrite=0

" ~~~~~~~~~~~ PYMODE
let g:pymode=1
let g:pymode_python='python3'
let g:pymode_options_max_line_length=120
let g:pymode_rope=1
let g:pymode_rope_lookup_project=0
let g:pymode_rope_regenerate_on_write=1
let g:pymode_rope_completion=0
let g:pymode_rope_autoimport=1
let g:pymode_rope_goto_definition_cmd='vnew'

let g:pymode_syntax=1
let g:pymode_syntax_slow_sync=0
let g:pymode_syntax_all=1
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all
let g:pymode_folding=0
let g:pymode_indent=1
let g:pymode_lint_on_fly = 0
let g:pymode_lint=0
let g:pymode_lint_on_write=0
let g:pymode_lint_checkers = []
let g:pymode_lint_checkers = ['pylint', 'pyflakes', 'mccabe']
let g:pymode_lint_cwindow=0
let g:pymode_lint_signs=0
let g:pymode_lint_ignore = ["C0111","C0411","C0103","R0903","C0330","R0201"]

" ~~~~~~~~~~~ COMMANDT
let g:CommandTScanDotDirectories=0

" ~~~~~~~~~~~ GUNDO
let g:gundo_prefer_python3=1
"
" ~~~~~~~~~~~ RAINBOW
let g:rainbow_active = 1

" ~~~~~~~~~~~ GREP
" Custom search function
function! Search(sought)
    exe "vimgrep ".a:sought." `find . -type f
                            \ ! -path '*/\.*' -prune
                            \ ! -path '*/node_modules/*' -prune
                            \ ! -path '*.pyc -prune
                            \ ! -path '*.ipynb -prune
                            \ ! -path '*.swp' -prune
                            \ ! -path '*/src/*' -prune
                            \ ! -path '*/*.mime' -prune
                            \ ! -path '*/vendored/*' -prune
                            \ ! -path '*/metrics/*' -prune`"
    exe "cwindow"
endfunction
command! -nargs=1 Search call Search(<f-args>)
nnoremap <Leader>s :%s/<C-r><C-w>/g

" ~~~~~~~~~~ SEARCH THRU CODE
nnoremap <Leader>mgu :call Search("<cword>")<CR>
let g:pymode_rope_goto_definition_bind='<Leader>mgd'
"
" ~~~~~~~~~~ OTHER PYTHON
let g:pymode_rope_rename_bind='<Leader>ren'
nnoremap <Leader>im :PymodeRopeAutoImport<CR>
nmap <silent> <buffer> gK <Plug>(kite-docs)
let g:kite_tab_complete=1

" ~~~~~~~~~~ Y AND D$
map Y y$
map D d$

" ~~~~~~~~~~~ FILEZZZ
let g:ranger_map_keys = 0
map <leader>fr :Ranger<CR>
map <Leader>ft :NERDTreeToggle<CR>
map <Leader>ft :NERDTreeToggle<CR>
map <Leader>' :25Term<CR>
nmap <silent> <Leader>ff <Plug>(CommandT)

" ~~~~~~~~~~ GIT MAPPINGS
map <Leader>gb :Gblame<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gm :Gmove
map <Leader>gdel :Gdelete<CR>
map <Leader>gdi :Gdiff<CR>
map <Leader>gl :Glog<CR>
map <Leader>gw :Gwrite<CR>

" ~~~~~~~~~~~ WINDOW AND BUFFER JUMPING AND RESIZING
map <Leader>tab :tabedit<CR>
map <Leader>h <C-w>h
map <Leader>j <C-w>j
map <Leader>k <C-w>k
map <Leader>l <C-w>l
nnoremap <C-t> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <A-t> :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <A-p> :bprevious<CR>:redraw<CR>:ls<CR>
nnoremap <silent> = :exe "resize +5"<CR>
nnoremap <silent> - :exe "resize -5"<CR>
nmap <silent> <Leader>= :exe "vertical resize +10"<CR>
nmap <silent> <Leader>- :exe "vertical resize -10"<CR>

" ~~~~~~~~~~~ WHITESPACE
nnoremap <Leader>w :ToggleWhitespace<CR>
nnoremap <Leader>q :StripWhitespace<CR>

" ~~~~~~~~~~~ SORT
xnoremap <Leader>a :sort i<CR>

" ~~~~~~~~~~~ GUNDO MAPPINGS
nnoremap <Leader>gundo :GundoToggle<CR>

" ~~~~~~~~~~~ NOHL ON <C-L>
nnoremap <C-L> :nohl<CR><C-L>

" ~~~~~~~~~~~ PRETTIFY JSON
map <Leader>pret :%!python -m json.tool<CR>

" ~~~~~~~~~~~ BLACK
map ,= :Black<CR>
let g:black_linelength = 120

function! B(line_length)
    let g:black_linelength = a:line_length
endfunction

command! -nargs=1 B call B(<f-args>)
nnoremap <Leader>b80 :B 80<CR>
nnoremap <Leader>b88 :B 88<CR>
nnoremap <Leader>b100 :B 100<CR>
nnoremap <Leader>b120 :B 120<CR>

" ~~~~~~~~~~~~ MAKEZ EMOJIZ
nmap <Leader>emo :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>

" ~~~~~~~~~~~~ OPEN DIS
nnoremap <Leader>conf :vsp ~/.config/nvim/init.vim<CR><C-L>

nnoremap <Leader>d :Goyo<CR> " distraction free mode
let g:goyo_width=120
let g:goyo_linenr=1

" ~~~~~~~~~~~~ ALE
let g:ale_enabled = 1

let g:ale_python_pylint_exectuable = "~/.pyenv/versions/neovim3/bin/pylint"
let g:ale_python_flake8_exectuable = "~/.pyenv/versions/neovim3/bin/flake8"
let g:ale_python_pyflakes_exectuable = "~/.pyenv/versions/neovim3/bin/pyflakes"
let g:ale_python_mypy_exectuable = "~/.pyenv/versions/neovim3/bin/mypy"

let g:ale_sign_column_always = 1
let g:ale_linters = {'python': ['pylint', 'flake8', 'pyflakes', 'mypy']}
let g:ale_python_pylint_options = "--disable=C0111,C0411,C0103,R0903,C0330,R0201,C0301,E0401,W0120,R0902"
let g:ale_python_mypy_options = "--ignore-missing-imports --python-version=3.7 --strict-optional=False"
let g:ale_python_flake8_options = "--ignore=N802,E203,W503,W504, --max-line-length=120"

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
"
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_set_loclist = 1
let g:ale_open_list = 0


" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
