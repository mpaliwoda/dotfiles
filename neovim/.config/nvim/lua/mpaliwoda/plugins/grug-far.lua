return {
    "MagicDuck/grug-far.nvim",
    opts = {
        cmd = "rg",
        confirm = true,
        preview = true,
        border = "rounded",
    },
    keys = {
        {
            "<leader>sr",
            function()
                local word = vim.fn.expand("<cword>")
                require("grug-far").open({ search = word })
            end,
            desc = "Search-replace word under cursor (grug-far)",
        },
        {
            "<leader>sp",
            function()
                local buf = vim.api.nvim_buf_get_name(0)
                require("grug-far").open({ search_paths = { buf } })
            end,
            desc = "Search in current file (grug-far)",
        },
        {
            "<leader>s",
            function()
                local mode = vim.fn.mode()
                local search
                if mode == "v" or mode == "V" then
                    local _, ls, cs = unpack(vim.fn.getpos("'<"))
                    local _, le, ce = unpack(vim.fn.getpos("'>"))
                    local lines = vim.fn.getline(ls, le)
                    if #lines > 0 then
                        lines[#lines] = string.sub(lines[#lines], 1, ce)
                        lines[1] = string.sub(lines[1], cs)
                        search = table.concat(lines, "\n")
                    end
                end
                require("grug-far").open({ search = search })
            end,
            mode = { "n", "v" },
            desc = "Search (grug-far)",
        },
    },
}
