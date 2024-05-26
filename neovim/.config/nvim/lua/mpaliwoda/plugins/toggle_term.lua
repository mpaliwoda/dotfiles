return {
    'akinsho/toggleterm.nvim',
    opts = {
        shell = "/bin/zsh",
    },
    keys = {
        { "<leader>t1",  "<cmd>ToggleTerm 1<cr>" },
        { "<leader>t2",  "<cmd>ToggleTerm 2<cr>" },
        { "<leader>t3",  "<cmd>ToggleTerm 3<cr>" },
        { "<leader>t4",  "<cmd>ToggleTerm 4<cr>" },
        { "<leader>t5",  "<cmd>ToggleTerm 5<cr>" },

        { "<leader>tf1", "<cmd>ToggleTerm 1 direction=float<cr>" },
        { "<leader>tf2", "<cmd>ToggleTerm 2 direction=float<cr>" },
        { "<leader>tf3", "<cmd>ToggleTerm 3 direction=float<cr>" },
        { "<leader>tf4", "<cmd>ToggleTerm 4 direction=float<cr>" },
        { "<leader>tf5", "<cmd>ToggleTerm 5 direction=float<cr>" },

        { "<leader>'",   "<cmd>ToggleTerm size=25 direction=horizontal<cr>" },
        { '<leader>"',   "<cmd>ToggleTerm direction=float<cr>" },
        { "<leader>'",   "<cmd>ToggleTermSendVisualSelection<cr>", mode = {"v"} },
    },
}
