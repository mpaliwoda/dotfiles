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
    call dein#add('ambv/black')                     " autoformatter
    call dein#add('python-mode/python-mode')        " general python plugin

    " other langs or general
    call dein#add('fatih/vim-go')                   " general go plugin
    call dein#add('hashivim/vim-terraform')         " terraforem
    call dein#add('maralla/completor.vim')          " autocomplete
    call dein#add('w0rp/ale')                       " linters

    " editing stuff
    call dein#add('ntpeters/vim-better-whitespace') " visual hints + stripping whitespace
    call dein#add('tpope/vim-commentary')           " helps commenting out code
    call dein#add('tpope/vim-surround')             " parenthesis-surrounding helper

    " git
    call dein#add('airblade/vim-gitgutter.git')     " shows changes in the file in column next to line no
    call dein#add('rhysd/committia.vim')            " fancy commit msg editing
    call dein#add('tpope/vim-fugitive')             " general git plugin

    " visual hints
    call dein#add('machakann/vim-highlightedyank')  " highlights what was yanked
    call dein#add('RRethy/vim-illuminate.git')      " highlights all occurrences of word under cursor
    call dein#add('thaerkh/vim-indentguides')       " shows indents visually
    call dein#add('Xuyuanp/nerdtree-git-plugin')    " show which files changed on nerdtree
    call dein#add('luochen1990/rainbow')            " matching parenthesis using colors

    " ui
    call dein#add('ryanoasis/vim-devicons')         " glyphs
    call dein#add('vim-airline/vim-airline')        " pretty statusline
    call dein#add('vim-airline/vim-airline-themes') " even prettier themes for statusline

    " colorschemes
    call dein#add('fatih/molokai')

    " trees and tabs
    call dein#add('sjl/gundo.vim')                  " shows undo tree
    call dein#add('scrooloose/nerdtree')            " filetree
    call dein#add('majutsushi/tagbar')              " shows all tags in the current file
    call dein#add('sodapopcan/vim-twiggy')          " git branch tree

    " file searching and tags
    call dein#add('wincent/command-t')              " fuzzy file searching
    call dein#add('xolox/vim-easytags')             " autogenerate ctags
    call dein#add('xolox/vim-misc')                 " esaytags dependency
    call dein#add('jremmen/vim-ripgrep')            " fast grep for custom searches

    " misc
    call dein#add('vimlab/split-term.vim')          " :10Term and stuff
    call dein#add('junegunn/vim-emoji')             " emoji support
    call dein#add('junegunn/goyo.vim')              " distraction free mode
    call dein#add('dhruvasagar/vim-table-mode')     " creating tables
    call dein#add('gilsondev/searchtasks.vim')      " search for todos in code

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
