return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main", lazy = true },
    },
    config = function()
        require("nvim-treesitter").setup()

        local ts_textobjects = require("nvim-treesitter-textobjects")
        ts_textobjects.setup({
            select = { lookahead = true },
            move = { set_jumps = true },
        })

        local select = require("nvim-treesitter-textobjects.select").select_textobject
        local swap = require("nvim-treesitter-textobjects.swap")
        local move = require("nvim-treesitter-textobjects.move")

        local map = vim.keymap.set

        -- swap
        map("n", "<M-L>", function() swap.swap_next("@parameter.inner") end)
        map("n", "<M-H>", function() swap.swap_previous("@parameter.inner") end)

        -- move
        map({ "n", "x", "o" }, "]p", function() move.goto_next_start("@parameter.inner", "textobjects") end)
        map({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end)
        map({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer", "textobjects") end)
        map({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end)
        map({ "n", "x", "o" }, "][", function() move.goto_next_end("@class.outer", "textobjects") end)
        map({ "n", "x", "o" }, "[p", function() move.goto_previous_start("@parameter.inner", "textobjects") end)
        map({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end)
        map({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer", "textobjects") end)
        map({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end)
        map({ "n", "x", "o" }, "[]", function() move.goto_previous_end("@class.outer", "textobjects") end)

        -- select
        map({ "x", "o" }, "aF", function() select("@function.outer", "textobjects") end)
        map({ "x", "o" }, "iF", function() select("@function.inner", "textobjects") end)
        map({ "x", "o" }, "ac", function() select("@conditional.outer", "textobjects") end)
        map({ "x", "o" }, "ic", function() select("@conditional.inner", "textobjects") end)
        map({ "x", "o" }, "aa", function() select("@parameter.outer", "textobjects") end)
        map({ "x", "o" }, "ia", function() select("@parameter.inner", "textobjects") end)
        map({ "x", "o" }, "av", function() select("@variable.outer", "textobjects") end)
        map({ "x", "o" }, "iv", function() select("@variable.inner", "textobjects") end)
        map({ "x", "o" }, "iC", function() select("@class.inner", "textobjects") end)
        map({ "x", "o" }, "aC", function() select("@class.outer", "textobjects") end)
        map({ "x", "o" }, "il", function() select("@loop.inner", "textobjects") end)
        map({ "x", "o" }, "al", function() select("@loop.outer", "textobjects") end)
        map({ "x", "o" }, "af", function() select("@call.outer", "textobjects") end)
        map({ "x", "o" }, "if", function() select("@call.inner", "textobjects") end)
    end,
}
