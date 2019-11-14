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
map <leader>fr :Ranger<CR>
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
nnoremap <Leader>d :Goyo<CR>
nnoremap <Leader>q :StripWhitespace<CR>
nnoremap <Leader>undo :GundoToggle<CR>
nnoremap <Leader>w :ToggleWhitespace<CR>
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


inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use TAB to complete when typing words, else inserts TABs as usual.  Uses
" dictionary, source files, and completor to find matching words to complete.

" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab to trigger auto completion.  Default suggests completions as you type.
let g:completor_auto_trigger = 0
inoremap <expr> <Tab> Tab_Or_Complete()
nmap <Leader>tag :TagbarToggle<CR>


nmap <Leader>todo :SearchTasks %<CR>
nmap <Leader>twig :Twiggy<CR>
