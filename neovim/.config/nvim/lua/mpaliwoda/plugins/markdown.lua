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

        local headings = vim.tbl_deep_extend(
            'force',
            presets.headings.slanted,
            presets.horizontal_rules.double,
            {
                heading_1 = { sign = "" },
                heading_2 = { sign = "" },

                setext_1 = { sign = "" },
                setext_2 = { sign = "" }
            }
        )

        markview.setup({
            markdown = { headings = headings, },
            checkboxes = presets.checkboxes.nerd,
            code_blocks = { sign = false, },
        });

        vim.keymap.set("n", "<C-M-m>", markview.commands.toggleAll)
        vim.keymap.set("n", "<C-M-h>i", require("markview.extras.headings").increase)
        vim.keymap.set("n", "<C-M-h>o", require("markview.extras.headings").decrease)
    end
}
