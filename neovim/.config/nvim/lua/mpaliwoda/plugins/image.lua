package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

return {
    "3rd/image.nvim",
    opts = {
        max_width_window_percentage = 100,
        window_overlap_clear_enabled = true,
    },
}
