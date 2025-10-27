return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = {
        options = {
            theme = "auto",
            globalstatus = true,
        },
        sections = {
            lualine_x = {
                "encoding",
                "fileformat",
                "filetype",
            },
            lualine_y = {
                "progress",
            },
        },
        tabline = {
            lualine_a = {
                {
                    "tabs",
                    mode = 2,
                },
            },
            lualine_y = {
                {
                    "filename",
                    path = 3,
                },
            },
        },
        extensions = {
            "fugitive",
            "nvim-dap-ui",
            "nvim-tree",
            "toggleterm",
        },
    },
}
