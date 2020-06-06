set nocompatible                        " no vi mode

" Required:
set runtimepath+=$HOME/.dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state($HOME.'/.dein')
    call dein#begin($HOME.'/.dein')

    " Let dein manage dein
    " Required:
    call dein#add($HOME.'/.dein/repos/github.com/Shougo/dein.vim')

    " python specific
    call dein#add('ambv/black')
    call dein#add('python-mode/python-mode')
    call dein#add('numirias/semshi')

    " other langs or general
    call dein#add('w0rp/ale')
    call dein#add('sheerun/vim-polyglot')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/neco-syntax')
    call dein#add('davidhalter/jedi')
    call dein#add('deoplete-plugins/deoplete-jedi')

    " editing stuff
    call dein#add('ntpeters/vim-better-whitespace')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-surround')

    " git
    call dein#add('airblade/vim-gitgutter.git')
    call dein#add('rhysd/committia.vim')
    call dein#add('tpope/vim-fugitive')

    " visual hints
    call dein#add('machakann/vim-highlightedyank')
    call dein#add('thaerkh/vim-indentguides')
    call dein#add('Xuyuanp/nerdtree-git-plugin')
    call dein#add('luochen1990/rainbow')            " matching parenthesis using colors

    " ui
    call dein#add('rbong/vim-crystalline')
    call dein#add('majutsushi/tagbar')

    " colorschemes
    call dein#add('fatih/molokai')

    " trees and tabs
    call dein#add('sjl/gundo.vim')                  " shows undo tree
    call dein#add('scrooloose/nerdtree')

    " file searching and tags
    call dein#add('wincent/command-t')              " fuzzy file searching
    call dein#add('jremmen/vim-ripgrep')            " fast grep for custom searches
    call dein#add('ludovicchabant/vim-gutentags')
    call dein#add('skywind3000/gutentags_plus')
    call dein#add('junegunn/fzf')
    call dein#add('junegunn/fzf.vim')

    " misc
    call dein#add('vimlab/split-term.vim')          " :10Term and stuff
    call dein#add('junegunn/vim-emoji')             " emoji support
    call dein#add('dhruvasagar/vim-table-mode')     " creating tables
    call dein#add('gilsondev/searchtasks.vim')      " search for todos in code
    call dein#add('SirVer/ultisnips')
    call dein#add('psliwka/vim-smoothie')

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

let g:python3_host_prog=$HOME.'/.pyenv/versions/neovim3/bin/python'

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

set autoread

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

augroup twospacesindent
    autocmd!
    autocmd BufNewFile,BufRead *.js, *.html, *.css, *.rb, *.yml, *.yaml set tabstop=2
    autocmd BufNewFile,BufRead *.js, *.html, *.css, *.rb, *.yml, *.yaml set softtabstop=2
    autocmd BufNewFile,BufRead *.js, *.html, *.css, *.rb, *.yml, *.yaml set shiftwidth=2
augroup END

set background=dark
set termguicolors

" let g:quantum_black=1
colorscheme molokai

let g:molokai_original=0


function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %f%h%w%m%r '
  if a:current
    let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
  endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! TabLine()
  let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
  return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'molokai'

set showtabline=1
set laststatus=1


let g:completor_python_binary='~/.pyenv/versions/neovim3/bin/python'

let g:pymode=1
let g:pymode_options_max_line_length=120
let g:pymode_python='python3'
let g:pymode_rope=1
let g:pymode_rope_autoimport=1
let g:pymode_rope_completion=0
let g:pymode_rope_goto_definition_cmd='vnew'
let g:pymode_rope_lookup_project=0
let g:pymode_rope_regenerate_on_write=0

let g:pymode_folding=0
let g:pymode_indent=1
let g:pymode_lint=0
let g:pymode_lint_checkers = []
let g:pymode_lint_checkers = []
let g:pymode_lint_cwindow=0
let g:pymode_lint_ignore = []
let g:pymode_lint_on_fly = 0
let g:pymode_lint_on_write=0
let g:pymode_lint_signs=0
let g:pymode_syntax=0
let g:pymode_syntax_all=0
let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
let g:pymode_syntax_builtin_types=g:pymode_syntax_all
let g:pymode_syntax_docstrings=g:pymode_syntax_all
let g:pymode_syntax_doctests=g:pymode_syntax_all
let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
let g:pymode_syntax_highlight_self=g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
let g:pymode_syntax_indent_errors=g:pymode_syntax_all
let g:pymode_syntax_print_as_function=g:pymode_syntax_all
let g:pymode_syntax_slow_sync=0
let g:pymode_syntax_space_errors=g:pymode_syntax_all
let g:pymode_syntax_string_format=g:pymode_syntax_all
let g:pymode_syntax_string_formatting=g:pymode_syntax_all
let g:pymode_syntax_string_templates=g:pymode_syntax_all

let g:ale_enabled = 1
let g:ale_linters = {'python': ['flake8', 'mypy']}
let g:ale_python_flake8_exectuable = "~/.pyenv/versions/neovim3/bin/flake8"
let g:ale_python_flake8_options = "--ignore=N802,E203,W503,W504, --max-line-length=120"
let g:ale_python_mypy_exectuable = "~/.pyenv/versions/neovim3/bin/mypy"
let g:ale_python_mypy_options = "--ignore-missing-imports --python-version=3.7"

let g:ale_sign_column_always = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
"
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_linters_explicit = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:airline#extensions#ale#enabled = 1

let g:ale_open_list = 0
let g:ale_set_loclist = 1


function! B(line_length)
    let g:black_linelength = a:line_length
endfunction

command! -nargs=1 B call B(<f-args>)
nnoremap <Leader>b100 :B 100<CR>
nnoremap <Leader>b120 :B 120<CR>
nnoremap <Leader>b80 :B 80<CR>
nnoremap <Leader>b88 :B 88<CR>
let g:black_virtualenv = $HOME.'/.pyenv/versions/neovim3'

map ,= :Black<CR>
let g:black_linelength = 120

let g:pymode_rope_goto_definition_bind='<Leader>mgd'
let g:pymode_rope_rename_bind='<Leader>ren'
nnoremap <Leader>im :PymodeRopeAutoImport<CR>

autocmd BufWritePre *.py execute ':Black'


let g:completor_python_binary = $HOME.'.pyenv/versions/neovim3/bin/python'

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']
let g:NERDTreeMinimalUI=1
let g:NERDTreeUpdateOnWrite=1

let g:CommandTScanDotDirectories=0
let g:gundo_prefer_python3=1
let g:rainbow_active = 1

set completefunc=emoji#complete

let g:rg_highlight=1
"
" Git
map <Leader>gb :Gblame<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gm :Gmove
map <Leader>gdel :Gdelete<CR>
map <Leader>gdi :Gdiff<CR>
map <Leader>gl :Glog<CR>
map <Leader>gw :Gwrite<CR>

" Window, tab & buffer jumping + resizing
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

" Files
let g:ranger_map_keys = 0
map <Leader>fs :NERDTreeFind<CR>
map <Leader>ft :NERDTreeToggle<CR>
nmap <silent> <Leader>ff <Plug>(CommandT)


" Misc
map Y y$
map D d$
map <Leader>' :25Term<CR>
map <Leader>pret :%!python -m json.tool<CR>
nmap <Leader>emo :%s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g<CR>
nnoremap <C-L> :nohl<CR><C-L>
nnoremap <Leader>conf :vsp ~/.config/nvim/init.vim<CR>
nnoremap <Leader>q :StripWhitespace<CR>
nnoremap <Leader>undo :GundoToggle<CR>
xnoremap <Leader>a :sort i<CR>


function! Search(sought)
    exe "Rg ".a:sought."
                        \ -g '!*/\.*'
                        \ -g '!*/node_modules/*'
                        \ -g '!*.pyc'
                        \ -g '!*.ipynb'
                        \ -g '!*.swp'
                        \ -g '!*/src/*'
                        \ -g '!*/*.mime'
                        \ -g '!*/vendored/*'
                        \ -g '!*/metrics/*'
                        \"
" exe "cwindow"
endfunction

command! -nargs=1 Search call Search(<f-args>)
nnoremap <Leader>s :%s/<C-r><C-w>/g
nnoremap <Leader>mgu :call Search("<cword>")<CR>

nmap <Leader>tag :TagbarToggle<CR>

nmap <Leader>todo :SearchTasks %<CR>

nmap <Leader>ru :silent !rufo %<CR>


let g:UltiSnipsExpandTrigger = '<C-B>'


let g:deoplete#enable_at_startup = 1


nmap <Leader>isort :! ~/.pyenv/versions/neovim3/bin/python -m isort %<CR>



" cscope
function! Cscope(option, query)
  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
  let opts = {
  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
  \ 'options': ['--ansi', '--prompt', '> ',
  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
  \ 'down': '40%'
  \ }
  echo opts
  function! opts.sink(lines)
    let data = split(a:lines)
    let file = split(data[0], ":")
    execute 'e ' . '+' . file[1] . ' ' . file[0]
  endfunction
  call fzf#run(opts)
endfunction

" Invoke command. 'g' is for call graph, kinda.
nnoremap <silent> <Leader>mgs :call Cscope('3', expand('<cword>'))<CR>


let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_project_root = ['.git']


set cscopetag
set csto=0
set tags=./tags,tags;/
