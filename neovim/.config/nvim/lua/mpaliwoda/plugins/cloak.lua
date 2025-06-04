return {
    "laytan/cloak.nvim",
    config = function()
        local cloak = require("cloak")

        cloak.setup({
            enabled = true,
            patterns = {
                {
                    file_pattern = ".env*",
                    cloak_pattern = "=.+",
                },
                {
                    file_pattern = "*.env",
                    cloak_pattern = "=.+",
                },
            },
        })

        vim.keymap.set("n", "<C-M-c>", "<cmd>CloakToggle<cr>")
    end,
}
