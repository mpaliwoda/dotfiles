let mapleader="\<SPACE>"

" configs
nnoremap <Leader>conf :vsp ~/.config/nvim/init.lua<CR>

" general
noremap Y y$
noremap D d$
noremap <Leader>' :25Term<CR>
nnoremap <C-L> :nohl<CR><C-L>

" window, tab & buffer jumping + resizing
nnoremap <Leader>h :wincmd h<CR>
nnoremap <Leader>j :wincmd j<CR>
nnoremap <Leader>k :wincmd k<CR>
nnoremap <Leader>l :wincmd l<CR>
nnoremap <Leader>tab :tabedit<CR>
nnoremap <C-t> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <A-t> :bnext<CR>:redraw<CR>:ls<CR>
nnoremap <A-p> :bprevious<CR>:redraw<CR>:ls<CR>
nnoremap <silent> = :exe "resize +5"<CR>
nnoremap <silent> - :exe "resize -5"<CR>
nnoremap <silent> <Leader>= :exe "vertical resize +10"<CR>
nnoremap <silent> <Leader>- :exe "vertical resize -10"<CR>

" telescope
nnoremap <Leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ui toggles
nnoremap <Leader>goyo :Goyo<CR>
nnoremap <Leader>tag :TagbarToggle<CR>
nnoremap <Leader>undo :MundoToggle<CR>

" nvimtree
nnoremap <Leader>ft :NvimTreeToggle<CR>
nnoremap <Leader>fs :NvimTreeFindFile<CR>
nnoremap <leader>fr :NvimTreeRefresh<CR>

" git
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gc :Git commit<CR>
noremap <Leader>gs :Git status<CR>
noremap <Leader>gm :GMove 
noremap <Leader>gdel :Gdelete<CR>
noremap <Leader>gdi :Gdiff<CR>
noremap <Leader>gl :Git log<CR>
noremap <Leader>gw :Gwrite<CR>

" completion and code actions
" Helpers for coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <Leader>coc :Telescope coc<CR>

nnoremap <silent> <Leader>mgd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> <Leader>mgy :call CocActionAsync('jumpTypeDefinition')<CR>
nnoremap <silent> <Leader>mgi :call CocActionAsync('jumpImplementation')<CR>
nnoremap <silent> <Leader>mgs :Telescope coc references<CR>

nnoremap <silent> diag :Telescope coc diagnostics<CR>
nnoremap <silent> [g :call CocActionAsync('diagnosticPrevious')<CR>
nnoremap <silent> ]g :call CocActionAsync('diagnosticNext')<CR>

xnoremap <leader>fmt  :call CocActionAsync('formatSelected', visualmode())<CR>
nnoremap <leader>fmt  :call CocActionAsync('format')<CR>
nnoremap <Leader>isort :call CocAction('runCommand', 'editor.action.organizeImport')<CR>

nnoremap <leader><space> :call CocActionAsync('codeAction', '')<CR>
xnoremap <leader><space> :call CocActionAsync('codeAction', visualmode())<CR>
nnoremap <silent> <Leader>fix :call CocActionAsync('doQuickfix')<CR>

inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <silent><nowait> <Leader>com  :Telescope coc commands<cr>

nnoremap <Leader>s :%s/<C-r><C-w>/g
nnoremap <Leader>ren :call CocActionAsync('rename')<CR>
nnoremap <Leder>ref :call CocActionAsync('refactor')<CR>
vnoremap <Leader>a :sort i<CR>

nnoremap <silent> <Leader>glow :Glow<CR>
nnoremap <silent> <Leader>twi :Twilight<CR>
