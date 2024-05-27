return {
    "rcarriga/nvim-notify",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("notify").setup({
            fps = 60,
            timeout = 1000,
            render = "compact",
            stages = "slide",
        })

        require("telescope").load_extension("notify")
    end,
}
