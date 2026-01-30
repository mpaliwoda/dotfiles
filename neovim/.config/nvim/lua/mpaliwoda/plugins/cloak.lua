return {
    "laytan/cloak.nvim",
    ft = { "sh", "zsh", "bash", "conf" },
    keys = { { "<C-M-c>", "<cmd>CloakToggle<cr>", desc = "Toggle cloak" } },
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
    end,
}
