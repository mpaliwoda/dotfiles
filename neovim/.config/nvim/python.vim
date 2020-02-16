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
