let mapleader="\<SPACE>"

" telescope
nnoremap <Leader>ff      <cmd>Telescope find_files<cr>
nnoremap <leader>fg      <cmd>Telescope live_grep<cr>
nnoremap <leader>fb      <cmd>Telescope buffers<cr>
nnoremap <leader>fh      <cmd>Telescope help_tags<cr>
nnoremap <leader>fy      <cmd>Telescope neoclip<cr>
nnoremap <leader>fe      <cmd>Telescope file_browser<cr>

" nvimtree
nnoremap <Leader>ft      <cmd>NvimTreeToggle<cr>
nnoremap <Leader>fs      <cmd>NvimTreeFindFile<cr>
nnoremap <leader>fr      <cmd>NvimTreeRefresh<cr>

" git
noremap <Leader>gg       <cmd>G<cr>
noremap <Leader>gc       <cmd>Git commit<cr>
noremap <Leader>gl       <cmd>Git log<cr>
noremap <Leader>gb       <cmd>Git blame<cr>
noremap <Leader>gdi      <cmd>Gdiff<cr>
noremap <Leader>gdel     <cmd>GRemove<cr>
noremap <Leader>gp       <cmd>Git push<cr>
noremap <Leader>gw       <cmd>Gwrite<cr>
noremap <Leader>gW       <cmd>Gwrite!<cr>
noremap <Leader>gh       <cmd>Telescope git_commits<cr>
noremap <Leader>gs       <cmd>Git stash<cr>
noremap <Leader>gS       <cmd>Telescope git_stash<cr>
noremap <Leader>gB       <cmd>Telescope git_branches<cr>
noremap <Leader>gm       <cmd>Git mergetool<cr>

nnoremap <leader>t1      <cmd>ToggleTerm 1<cr>
nnoremap <leader>t2      <cmd>ToggleTerm 2<cr>
nnoremap <leader>t3      <cmd>ToggleTerm 3<cr>
nnoremap <leader>t4      <cmd>ToggleTerm 4<cr>
nnoremap <leadee>t5      <cmd>ToggleTerm 5<cr>

nnoremap <leader>tf1     <cmd>ToggleTerm 1 direction=float<cr>
nnoremap <leader>tf2     <cmd>ToggleTerm 2 direction=float<cr>
nnoremap <leader>tf3     <cmd>ToggleTerm 3 direction=float<cr>
nnoremap <leader>tf4     <cmd>ToggleTerm 4 direction=float<cr>
nnoremap <leadee>tf5     <cmd>ToggleTerm 5 direction=float<cr>

nnoremap <leader>'       <cmd>ToggleTerm size=25 direction=horizontal<cr>
nnoremap <leader>"       <cmd>ToggleTerm direction=float<cr>
vnoremap <leader>'       <cmd>ToggleTermSendVisualSelection<cr>

nnoremap <leader>ww      <cmd>Telescope toggletasks spawn<cr>
nnoremap <leader>ws      <cmd>Telescope toggletasks select<cr>

nnoremap <leader>n       <cmd>HopWord<cr>
nnoremap <Leader>undo    <cmd>UndotreeToggle<cr>

tnoremap <Esc>           <C-\><C-n>

nnoremap <Leader>ab      <cmd>lua require'dap'.toggle_breakpoint()<cr>
nnoremap <Leader>ar      <cmd>lua require'dap'.repl.open()<cr>
nnoremap <Leader>au      <cmd>lua require'dapui'.toggle()<cr>

nnoremap <F5>            <cmd>lua require'dap'.continue()<cr>

nnoremap <F6>            <cmd>lua require'dap'.step_into()<cr>
nnoremap <F7>            <cmd>lua require'dap'.step_over()<cr>
nnoremap <F8>            <cmd>lua require'dap'.step_out()<cr>

nnoremap <F9>            <cmd>lua require'dap-python'.test_method()<cr>
vnoremap <F9>            <cmd>lua require'dap-python'.debug_selection()<cr>
nnoremap <F10>           <cmd>lua require('dap.ext.vscode').load_launchjs()<cr>


nnoremap <leader>S       <cmd>lua require('spectre').open()<cr>
nnoremap <leader>sw      <cmd>lua require('spectre').open_visual({select_word=true})<cr>
nnoremap <leader>sp      <cmd>lua require('spectre').open_file_search()<cr>
nnoremap <Leader>ss      :%s/<C-r><C-w>/
vnoremap <leader>s       <cmd>lua require('spectre').open_visual()<cr>

nnoremap <Leader>coc     <cmd>Telescope coc<cr>
nnoremap <Leader>com     <cmd>Telescope coc commands<cr>

nnoremap <Leader>mgd     <cmd>call CocActionAsync('jumpDefinition')<cr>
nnoremap <Leader>mgy     <cmd>call CocActionAsync('jumpTypeDefinition')<cr>
nnoremap <Leader>mgi     <cmd>call CocActionAsync('jumpImplementation')<cr>
nnoremap <Leader>mgF     <cmd>call CocActionAsync('doQuickfix')<cr>
nnoremap <Leader>mgs     <cmd>Telescope coc references<cr>
nnoremap <Leader>mgD     <cmd>Telescope coc diagnostics<cr>
nnoremap <Leader>mgq     <cmd>Telescope coc document_symbols<cr>
nnoremap <Leader>mgQ     <cmd>CocList -I symbols<cr>
nnoremap <leader>fmt     <cmd>call CocActionAsync('format')<cr>
xnoremap <leader>fmt     <cmd>call CocActionAsync('formatSelected', visualmode())<cr>
nnoremap [g              <cmd>call CocActionAsync('diagnosticPrevious')<cr>
nnoremap ]g              <cmd>call CocActionAsync('diagnosticNext')<cr>
nnoremap <M-d>           <cmd>call CocAction('diagnosticToggleBuffer')<cr>

nnoremap <Leader>isort   <cmd>call CocAction('runCommand', 'editor.action.organizeImport')<cr>

nnoremap <leader><space> <cmd>call CocActionAsync('codeAction', '')<cr>
xnoremap <leader><space> <cmd>call CocActionAsync('codeAction', visualmode())<cr>

nnoremap <Leader>ren     <cmd>call CocActionAsync('rename')<cr>
nnoremap <Leader>ref     <cmd>call CocActionAsync('refactor')<cr>
vnoremap <Leader>a       :sort i<cr>

inoremap <expr> <c-space> coc#refresh()

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


nnoremap <silent> K :call <SID>show_documentation()<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" general
noremap Y y$
noremap D d$
nnoremap <C-L> :nohl<cr><C-L>
"
" window, tab & buffer jumping + resizing
nnoremap <Leader>h :wincmd h<cr>
nnoremap <Leader>j :wincmd j<cr>
nnoremap <Leader>k :wincmd k<cr>
nnoremap <Leader>l :wincmd l<cr>
nnoremap <Leader>tab :tabedit<cr>
nnoremap <silent> = :exe "resize +5"<cr>
nnoremap <silent> - :exe "resize -5"<cr>
nnoremap <silent> <Leader>= :exe "vertical resize +10"<cr>
nnoremap <silent> <Leader>- :exe "vertical resize -10"<cr>

