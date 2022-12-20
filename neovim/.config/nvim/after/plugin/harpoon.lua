local present, _ = pcall(require, "harpoon")

if not present then
    vim.notify("Harpoon not installed.", "error")
    return
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-7>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-8>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-9>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-0>", function() ui.nav_file(4) end)
