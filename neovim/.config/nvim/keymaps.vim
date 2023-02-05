let mapleader="\<SPACE>"

" telescope
nnoremap <Leader>ff      <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg      <cmd>Telescope live_grep<cr>
nnoremap <leader>fb      <cmd>Telescope buffers<cr>
nnoremap <leader>fh      <cmd>Telescope help_tags<cr>
nnoremap <leader>fy      <cmd>Telescope neoclip<cr>
nnoremap <leader>fe      <cmd>Telescope file_browser<cr>
nnoremap <leader>fp      <cmd>Telescope git_files<cr>

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
noremap <Leader>gM       <cmd>Git mergetool<cr>

nnoremap <leader>t1      <cmd>ToggleTerm 1<cr>
nnoremap <leader>t2      <cmd>ToggleTerm 2<cr>
nnoremap <leader>t3      <cmd>ToggleTerm 3<cr>
nnoremap <leader>t4      <cmd>ToggleTerm 4<cr>
nnoremap <leader>t5      <cmd>ToggleTerm 5<cr>

nnoremap <leader>tf1     <cmd>ToggleTerm 1 direction=float<cr>
nnoremap <leader>tf2     <cmd>ToggleTerm 2 direction=float<cr>
nnoremap <leader>tf3     <cmd>ToggleTerm 3 direction=float<cr>
nnoremap <leader>tf4     <cmd>ToggleTerm 4 direction=float<cr>
nnoremap <leader>tf5     <cmd>ToggleTerm 5 direction=float<cr>

nnoremap <leader>'       <cmd>ToggleTerm size=25 direction=horizontal<cr>
nnoremap <leader>"       <cmd>ToggleTerm direction=float<cr>
vnoremap <leader>'       <cmd>ToggleTermSendVisualSelection<cr>

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

vnoremap <Leader>a       :sort i<cr>

" nnoremap <leader>dl       :lua require('nvim-docker').containers.list_containers()<cr>
nnoremap <M-t>            <cmd>TSContextToggle<cr>

" general
noremap Y y$
noremap D d$
nnoremap <silent> <C-L> :nohl<cr><C-L>
"
" window, tab & buffer jumping + resizing
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l
nnoremap <Leader>tab :tabedit<cr>
nnoremap <silent> = :exe "resize +5"<cr>
nnoremap <silent> - :exe "resize -5"<cr>
nnoremap <silent> <Leader>= :exe "vertical resize +10"<cr>
nnoremap <silent> <Leader>- :exe "vertical resize -10"<cr>

" nmap <F2> <Plug>(coc-codelens-action)
nmap <F3> <cmd>ToggleBlameLine<CR>

nmap <M-b> <cmd>Twiggy<CR>

vmap <M-k> :m '<-2<cr>gv=gv
vmap <M-j> :m '>+1<cr>gv=gv

nmap <M-c> <cmd>CloakToggle<cr>

nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

nmap <M-z> <cmd>ZenMode<cr>

nmap <M-o>p <Plug>SnipRun
vmap <M-o>p <Plug>SnipRun
nmap <M-o>i <Plug>SnipRunOperator
nmap <M-o>x <Plug>SnipReset
nmap <M-o>c <Plug>SnipClose
nmap <M-o>l <Plug>SnipLive

nmap <M-0> <cmd>CellularAutomaton make_it_rain<cr>
nmap <M-9> <cmd>CellularAutomaton game_of_life<cr>
