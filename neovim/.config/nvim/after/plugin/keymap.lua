vim.keymap.set("n", "<Leader>h", "<C-w>h")
vim.keymap.set("n", "<Leader>j", "<C-w>j")
vim.keymap.set("n", "<Leader>k", "<C-w>k")
vim.keymap.set("n", "<Leader>l", "<C-w>l")

vim.keymap.set("n", "<Leader>tab", ":tabedit<cr>", { silent = true })

vim.keymap.set("n", "=", ":exe 'resize +5'<cr>", { silent = true })
vim.keymap.set("n", "-", ":exe 'resize -5'<cr>", { silent = true })
vim.keymap.set("n", "<Leader>=", ":exe 'vertical resize +10'<cr>", { silent = true })
vim.keymap.set("n", "<Leader>-", ":exe 'vertical resize -10'<cr>", { silent = true })

vim.keymap.set("v", "<M-k>", ":m '<-2<cr>gv=gv", { silent = true })
vim.keymap.set("v", "<M-j>", ":m '>+1<cr>gv=gv", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "<Leader>a", ":sort i<cr>", { silent = true })

vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "D", "d$")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
