let g:python3_host_prog=$HOME.'/.pyenv/versions/neovim3/bin/python'

call plug#begin('~/.config/neovim/plugged')

" completion and linting
Plug 'neoclide/coc.nvim',   { 'merged': 0, 'branch': 'release'}

" file searching, tags
Plug 'wincent/command-t',   { 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
Plug 'jremmen/vim-ripgrep'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

" python specific
Plug 'ambv/black',          { 'for': 'python', 'branch': 'master' }
Plug 'numirias/semshi',     { 'for': 'python' }

" ui
Plug 'rbong/vim-crystalline'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'majutsushi/tagbar',   { 'on': 'TagbarToggle' }
Plug 'sjl/gundo.vim',       { 'on': 'GundoToggle' }
Plug 'vimlab/split-term.vim'
Plug 'psliwka/vim-smoothie'
Plug 'fatih/molokai'

" whitespace and commenting
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

" git
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/committia.vim'
Plug 'tpope/vim-fugitive'

" visual hints
Plug 'machakann/vim-highlightedyank'
Plug 'thaerkh/vim-indentguides'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'luochen1990/rainbow'

call plug#end()

" General settings
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
set pastetoggle=<F10>                   " paste/no-paste with F11 key
set cursorline
set ttyfast
set updatetime=100
set undodir=~/.config/nvim/undodir
set undofile
set shiftwidth=4
set softtabstop=4
set expandtab                           " use spaces when hitting tab
set splitbelow
set splitright
set nocursorcolumn
set scrolljump=5
set lazyredraw
set autoread
set background=dark
set termguicolors
set showtabline=1
set laststatus=1
set updatetime=300

colorscheme molokai
let g:molokai_original=0

let mapleader="\<SPACE>"

" autoupdate on write
augroup myvimrc
    au!
    au BufWritePost *.vim so $MYVIMRC
augroup END

" Configs
nmap <Leader>conf :vsp ~/.config/nvim/init.vim<CR>
nmap <Leader>coc :vsp ~/.config/nvim/coc-settings.json<CR>

" crystalline settings
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


" completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> mgd <Plug>(coc-definition)
nmap <silent> mgy <Plug>(coc-type-definition)
nmap <silent> mgi <Plug>(coc-implementation)
nmap <silent> mgs <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
xmap <leader>fmt  <Plug>(coc-format-selected)
nmap <leader>fmt  <Plug>(coc-format)
nmap <leader>pret  <Plug>(coc-format)
nmap <Leader>isort :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>ren <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Trees and file navigation
nmap <Leader>tag :TagbarToggle<CR>
nmap <Leader>undo :GundoToggle<CR>
nmap <silent> <Leader>ff <Plug>(CommandT)
nmap <Leader>fs :NERDTreeFind<CR>
nmap <Leader>ft :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']
let g:NERDTreeMinimalUI=1
let g:NERDTreeUpdateOnWrite=1

" Window, tab & buffer jumping + resizing
nmap <Leader>tab :tabedit<CR>
nmap <C-t> :bnext<CR>
nmap <C-p> :bprevious<CR>
nmap <A-t> :bnext<CR>:redraw<CR>:ls<CR>
nmap <A-p> :bprevious<CR>:redraw<CR>:ls<CR>
nmap <silent> = :exe "resize +5"<CR>
nmap <silent> - :exe "resize -5"<CR>
nmap <silent> <Leader>= :exe "vertical resize +10"<CR>
nmap <silent> <Leader>- :exe "vertical resize -10"<CR>

" Git
map <Leader>gb :Gblame<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gm :Gmove
map <Leader>gdel :Gdelete<CR>
map <Leader>gdi :Gdiff<CR>
map <Leader>gl :Glog<CR>
map <Leader>gw :Gwrite<CR>

" Misc 
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

map Y y$
map D d$
map <Leader>' :25Term<CR>
nnoremap <C-L> :nohl<CR><C-L>
nnoremap <Leader>q :StripWhitespace<CR>

let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_project_root = ['.git']

set cscopetag
set csto=0
set tags=./tags,tags;/

let g:indentguides_ignorelist = ['json']

