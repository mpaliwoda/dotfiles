return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
        bigfile = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        explorer = {
            enabled = true,
            replace_netrw = true,
        },
        picker = {
            enabled = true,
            hidden = true,
            sources = {
                explorer = {
                    supports_live = true,
                    tree = false,
                    watch = true,
                    diagnostics = false,
                    diagnostics_open = false,
                    git_status = true,
                    git_status_open = false,
                    git_untracked = true,
                    follow_file = true,
                    focus = "list",
                    auto_close = true,
                    jump = { close = true },
                    layout = { preset = "default", preview = true },
                    matcher = { sort_empty = false, fuzzy = true },
                    include = { ".*/" },
                    config = function(opts)
                        return require("snacks.picker.source.explorer").setup(opts)
                    end,
                },
            },
        },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
    },
    keys = {
        {
            "<leader>fs",
            function()
                Snacks.picker.smart()
            end,
            desc = "Smart Find Files",
        },
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>fn",
            function()
                Snacks.picker.notifications()
            end,
            desc = "Notification History",
        },
        {
            "<leader>ft",
            function()
                Snacks.explorer()
            end,
            desc = "File Explorer",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Visual selection or word",
            mode = { "n", "x" },
        },

        {
            "<leader>qb",
            function()
                Snacks.picker.git_branches()
            end,
            desc = "Git Branches",
        },
        {
            "<leader>ql",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Git Log",
        },
        {
            "<leader>qL",
            function()
                Snacks.picker.git_log_line()
            end,
            desc = "Git Log Line",
        },
        {
            "<leader>qs",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Git Status",
        },
        {
            "<leader>qS",
            function()
                Snacks.picker.git_stash()
            end,
            desc = "Git Stash",
        },
        {
            "<leader>qd",
            function()
                Snacks.picker.git_diff()
            end,
            desc = "Git Diff (Hunks)",
        },
        {
            "<leader>qf",
            function()
                Snacks.picker.git_log_file()
            end,
            desc = "Git Log File",
        },

        {
            "<leader>diag",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Diagnostics",
        },
        {
            "<leader>undo",
            function()
                Snacks.picker.undo()
            end,
            desc = "Undo History",
        },
    },
}
