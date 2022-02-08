autocmd CursorHold * silent call CocActionAsync('highlight')

augroup myvimrc
    au!
    au BufWritePost *.vim so $MYVIMRC
augroup END
