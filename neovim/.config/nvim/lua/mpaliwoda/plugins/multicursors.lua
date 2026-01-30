return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    keys = {
        { "<up>", mode = { "n", "x" }, desc = "Add cursor above" },
        { "<down>", mode = { "n", "x" }, desc = "Add cursor below" },
        { "<C-n>", mode = { "n", "x" }, desc = "Add cursor at match" },
        { "<C-s>", mode = { "n", "x" }, desc = "Skip match" },
        { "<c-leftmouse>", desc = "Add cursor with mouse" },
        { "<c-q>", mode = { "n", "x" }, desc = "Toggle cursor" },
    },
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        vim.keymap.set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
        vim.keymap.set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
        vim.keymap.set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
        vim.keymap.set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

        vim.keymap.set({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end)
        vim.keymap.set({ "n", "x" }, "<C-s>", function() mc.matchSkipCursor(1) end)
        vim.keymap.set({ "n", "x" }, "<C-M-n>", function() mc.matchAddCursor(-1) end)
        vim.keymap.set({ "n", "x" }, "<C-M-s>", function() mc.matchSkipCursor(-1) end)

        vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
        vim.keymap.set("n", "<c-leftdrag>", mc.handleMouseDrag)
        vim.keymap.set("n", "<c-leftrelease>", mc.handleMouseRelease)

        vim.keymap.set({ "n", "x" }, "<c-q>", mc.toggleCursor)

        mc.addKeymapLayer(function(layerSet)
            layerSet({ "n", "x" }, "<left>", mc.prevCursor)
            layerSet({ "n", "x" }, "<right>", mc.nextCursor)
            layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn" })
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
}
