return {
    "aznhe21/actions-preview.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    event = "LspAttach",
    config = function()
        local actions = require("actions-preview")

        actions.setup({
            highlight_command = {
               require("actions-preview.highlight").diff_so_fancy(),
            },
            telescope = require("telescope.themes").get_dropdown({ initial_mode = "normal" })
        })

        vim.keymap.set({ "n", "v" }, "<leader><space>", "<cmd>lua require('actions-preview').code_actions()<cr>")
    end,
}
