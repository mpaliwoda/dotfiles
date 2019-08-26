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

    " other langs or general
    call dein#add('hashivim/vim-terraform')
    call dein#add('w0rp/ale')
    call dein#add('maralla/completor.vim')

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
    call dein#add('RRethy/vim-illuminate.git')      " highlights all occurrences of word under cursor
    call dein#add('machakann/vim-highlightedyank')  " highlights what was yanked
    call dein#add('scrooloose/nerdtree')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('ryanoasis/vim-devicons')

    " colorschemes
    call dein#add('fatih/molokai')

    " misc
    call dein#add('sjl/gundo.vim')                  " shows undo tree
    call dein#add('vimlab/split-term.vim')          " :10Term and stuff
    call dein#add('wincent/command-t')              " fuzzy file searching
    call dein#add('junegunn/vim-emoji')
    call dein#add('junegunn/goyo.vim')              " distraction free mode
    call dein#add('dhruvasagar/vim-table-mode')
    call dein#add('jremmen/vim-ripgrep')

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
