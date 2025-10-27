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
        zen = {
            win = {
                style = {
                    enter = true,
                    fixbuf = true,
                    minimal = true,
                    width = 150,
                    height = 0,
                    backdrop = { transparent = true, blend = 10 },
                    keys = { q = false },
                    zindex = 40,
                    wo = {
                        winhighlight = "NormalFloat:Normal",
                    },
                    w = {
                        snacks_main = true,
                    },
                }
            }
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
        terminal = {
            enabled = true,
            shell = "/bin/zsh",
            win = {
                style = "terminal",
            },
        },
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
            "<leader>fh",
            function()
                Snacks.picker.help()
            end,
            desc = "Help pages",
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
        {
            "<leader>zen",
            function()
                Snacks.zen.zen()
            end,
            desc = "Zen",
        },
        { "<leader>t1",  function() Snacks.terminal.toggle(nil, { count = 1 }) end },
        { "<leader>t2",  function() Snacks.terminal.toggle(nil, { count = 2 }) end },
        { "<leader>t3",  function() Snacks.terminal.toggle(nil, { count = 3 }) end },
        { "<leader>t4",  function() Snacks.terminal.toggle(nil, { count = 4 }) end },
        { "<leader>t5",  function() Snacks.terminal.toggle(nil, { count = 5 }) end },

        -- floating versions
        { "<leader>tf1", function() Snacks.terminal.toggle(nil, { count = 1, win = { relative = "editor" } }) end },
        { "<leader>tf2", function() Snacks.terminal.toggle(nil, { count = 2, win = { relative = "editor" } }) end },
        { "<leader>tf3", function() Snacks.terminal.toggle(nil, { count = 3, win = { relative = "editor" } }) end },
        { "<leader>tf4", function() Snacks.terminal.toggle(nil, { count = 4, win = { relative = "editor" } }) end },
        { "<leader>tf5", function() Snacks.terminal.toggle(nil, { count = 5, win = { relative = "editor" } }) end },

        -- horizontal terminal (25 lines)
        {
            "<leader>'",
            function()
                Snacks.terminal.toggle(nil, {
                    win = { position = "bottom", height = 25 },
                })
            end,
            desc = "Toggle horizontal terminal",
        },

        -- floating terminal
        {
            '<leader>"',
            function()
                Snacks.terminal.toggle(nil, {
                    win = { relative = "editor", width = 0.8, height = 0.8 },
                })
            end,
            desc = "Toggle floating terminal",
        },

        -- send visual selection
        {
            "<leader>'",
            function()
                local start_pos = vim.fn.getpos("v")
                local end_pos = vim.fn.getpos(".")
                local lines = vim.fn.getregion(start_pos, end_pos)
                local text = table.concat(lines, "\n")
                local term = Snacks.terminal.get(nil, { create = true })
                term:show()
                if term.job then
                    vim.api.nvim_chan_send(term.job, text .. "\n")
                end
            end,
            mode = { "v" },
            desc = "Send selection to terminal",
        },
    },
}
