return {
    "aznhe21/actions-preview.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader><space>", function() require("actions-preview").code_actions() end, mode = { "n", "v" }, desc = "Code actions" },
    },
    config = function()
        require("actions-preview").setup({
            highlight_command = {
                require("actions-preview.highlight").diff_so_fancy(),
            },
        })
    end,
}
