autocmd CursorHold * silent! call CocActionAsync('highlight')

augroup htmldjango_ft
  au!
  autocmd BufNewFile,BufRead *.html      set ft=htmldjango
  autocmd BufNewFile,BufRead *.html.j2   set ft=htmldjango
  autocmd BufNewFile,BufRead *.jinja     set ft=htmldjango
augroup END

augroup dockerfiles
  au!
  autocmd BufNewFile,BufRead Dockerfile* set ft=dockerfile
augroup END

augroup terraform
  au!
  autocmd BufNewFile,BufRead *.tf        set ft=hcl
augroup END

augroup env_files
  au!
  autocmd BufNewFile,BufRead \.env*      set ft=bash
  autocmd BufNewFile,BufRead *\.env      set ft=bash
augroup END

augroup js
  au!
  autocmd BufNewFile,BufRead *\.es6      set ft=javascript
augroup END
