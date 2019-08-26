autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']
let g:NERDTreeMinimalUI=1
let g:NERDTreeUpdateOnWrite=1

let g:CommandTScanDotDirectories=0
let g:gundo_prefer_python3=1
let g:rainbow_active = 1

let g:goyo_width=120
let g:goyo_linenr=1

let g:polyglot_disabled = ['python', 'python-compiler', 'python-indent']
set completefunc=emoji#complete

let g:rg_highlight=1
