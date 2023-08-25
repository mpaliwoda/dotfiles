autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()

augroup dockerfiles
  au!
  autocmd BufNewFile,BufRead Dockerfile* set ft=dockerfile
augroup END

augroup terraform
  au!
  autocmd BufNewFile,BufRead *.tf        set ft=terraform
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

augroup fsharp
  au!
  autocmd BufNewFile,BufRead *.fs        set ft=fsharp
  autocmd BufNewFile,BufRead *.fsi       set ft=fsharp
  autocmd BufNewFile,BufRead *.fsx       set ft=fsharp
  autocmd BufNewFile,BufRead *.fsscript  set ft=fsharp
  autocmd BufNewFile,BufRead *.fsproj    set ft=xml
augroup END

autocmd VimEnter * if empty(expand('<amatch>'))|call FugitiveDetect(getcwd())|endif
