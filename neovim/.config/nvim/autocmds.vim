autocmd CursorHold * silent call CocActionAsync('highlight')

augroup myvimrc
    au!
    au BufWritePost ~/.config/nvim/*/*.vim so ~/.config/nvim/init.lua
    au BufWritePost ~/.config/nvim/*/*.lua so ~/.config/nvim/init.lua
augroup END
