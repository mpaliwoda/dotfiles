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
    call dein#add('vim-ruby/vim-ruby')
    call dein#add('maralla/completor.vim')
    call dein#add('w0rp/ale')

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
    call dein#add('vim-airline/vim-airline')        " pretty statusline
    call dein#add('vim-airline/vim-airline-themes')

    " colorschemes
    call dein#add('fatih/molokai')
    call dein#add('tyrannicaltoucan/vim-quantum')

    " trees and tabs
    call dein#add('sjl/gundo.vim')                  " shows undo tree
    call dein#add('scrooloose/nerdtree')

    " file searching and tags
    call dein#add('wincent/command-t')              " fuzzy file searching
    call dein#add('jremmen/vim-ripgrep')            " fast grep for custom searches

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

source $HOME/.config/nvim/basics.vim
source $HOME/.config/nvim/colorschemes.vim
source $HOME/.config/nvim/python.vim
source $HOME/.config/nvim/plugin_settings.vim
source $HOME/.config/nvim/mappings.vim
