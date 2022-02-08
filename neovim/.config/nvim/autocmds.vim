autocmd CursorHold * silent call CocActionAsync('highlight')

augroup myvimrc
    au!
    au BufWritePost *.vim so ~/.config/nvim/init.lua
    au BufWritePost *.lua so ~/.config/nvim/init.lua
augroup END
