return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local presets = require("markview.presets");
        local markview = require("markview")

        markview.setup({
            headings = vim.tbl_deep_extend('force', presets.headings.slanted, presets.horizontal_rules.double),
            checkboxes = presets.checkboxes.nerd,
        });

        vim.keymap.set("n", "<M-m>", function() markview.commands.toggleAll() end)
        vim.keymap.set("n", "<M-h>i", function() require("markview.extras.headings").increase() end)
        vim.keymap.set("n", "<M-h>o", function() require("markview.extras.headings").decrease() end)
    end
}
