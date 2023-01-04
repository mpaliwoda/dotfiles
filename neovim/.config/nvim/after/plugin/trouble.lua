prequire("trouble", function(trouble)
    trouble.setup()

    local noremap = { silent = true, noremap = true }

    local function next_diagnostic()
        vim.cmd [[Trouble]]
        trouble.next({ jump = true })
    end

    local function previous_diagnostic()
        vim.cmd [[Trouble]]
        trouble.previous({ jump = true })
    end

    vim.keymap.set("n", "<leader>diag", "<cmd>TroubleToggle<cr>", noremap)
    vim.keymap.set("n", "[G", previous_diagnostic, noremap)
    vim.keymap.set("n", "]G", next_diagnostic, noremap)
end)
