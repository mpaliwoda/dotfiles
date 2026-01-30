return {
    "wintermute-cell/gitignore.nvim",
    keys = {
        { "<leader>gi", function() require("gitignore").generate() end, desc = "Generate .gitignore" },
    },
}
