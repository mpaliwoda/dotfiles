autocmd CursorHold * silent! call CocActionAsync('highlight')

augroup htmldjango_ft
  au!
  autocmd BufNewFile,BufRead *.html      set ft=htmldjango
  autocmd BufNewFile,BufRead *.html.j2   set ft=htmldjango
  autocmd BufNewFile,BufRead *.jinja     set ft=htmldjango
augroup END

augroup terraform
  au!
  autocmd BufNewFile,BufRead *.tf        set ft=hcl
augroup END

augroup spellsitter
  au!
  autocmd TermOpen *                     setlocal nospell
augroup END
