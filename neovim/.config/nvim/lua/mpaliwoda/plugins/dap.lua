return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = { "mason-org/mason.nvim" },
                opts = {
                    automatic_installation = true,
                    -- Install only; the language plugins define the adapters.
                    handlers = {},
                    ensure_installed = {
                        "python",   -- debugpy
                        "codelldb",
                        "javadbg",  -- java-debug-adapter
                        "javatest", -- java-test
                    },
                },
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {
                    virt_text_pos = "eol",
                    commented = true,
                },
            },
        },
        keys = {
            { "<leader>dc", function() require("dap").continue() end,          desc = "Debug: continue / start" },
            { "<F5>",       function() require("dap").continue() end,          desc = "Debug: continue / start" },
            { "<leader>dn", function() require("dap").step_over() end,         desc = "Debug: step over" },
            { "<F10>",      function() require("dap").step_over() end,         desc = "Debug: step over" },
            { "<leader>ds", function() require("dap").step_into() end,         desc = "Debug: step into" },
            { "<F11>",      function() require("dap").step_into() end,         desc = "Debug: step into" },
            { "<leader>dO", function() require("dap").step_out() end,          desc = "Debug: step out" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle breakpoint" },
            {
                "<leader>dB",
                function()
                    vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
                        if cond and cond ~= "" then
                            require("dap").set_breakpoint(cond)
                        end
                    end)
                end,
                desc = "Debug: conditional breakpoint",
            },
            {
                "<leader>dp",
                function()
                    vim.ui.input({ prompt = "Log point message: " }, function(msg)
                        if msg and msg ~= "" then
                            require("dap").set_breakpoint(nil, nil, msg)
                        end
                    end)
                end,
                desc = "Debug: log point",
            },
            { "<leader>dr", function() require("dap").repl.toggle() end,   desc = "Debug: toggle REPL" },
            { "<leader>dL", function() require("dap").run_last() end,      desc = "Debug: run last" },
            { "<leader>dt", function() require("dap").terminate() end,     desc = "Debug: terminate" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Debug: run to cursor" },
            { "<leader>dk", function() require("dap").up() end,            desc = "Debug: frame up" },
            { "<leader>dj", function() require("dap").down() end,          desc = "Debug: frame down" },
        },
        config = function()
            local dap = require("dap")

            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError" })
            vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticSignWarn" })
            vim.fn.sign_define("DapLogPoint", { text = "◇", texthl = "DiagnosticSignInfo" })
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticSignHint", linehl = "Visual" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "✗", texthl = "DiagnosticSignError" })
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        keys = {
            { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: toggle UI" },
            {
                "<leader>de",
                function() require("dapui").eval(nil, { enter = true }) end,
                mode = { "n", "v" },
                desc = "Debug: evaluate expression",
            },
        },
        opts = {
            layouts = {
                {
                    position = "left",
                    size = 50,
                    elements = {
                        { id = "scopes",      size = 0.4 },
                        { id = "breakpoints", size = 0.2 },
                        { id = "stacks",      size = 0.2 },
                        { id = "watches",     size = 0.2 },
                    },
                },
                {
                    position = "bottom",
                    size = 12,
                    elements = {
                        { id = "repl",    size = 0.5 },
                        { id = "console", size = 0.5 },
                    },
                },
            },
        },
        config = function(_, opts)
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup(opts)

            dap.listeners.after.event_initialized["dapui"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui"] = function()
                dapui.close()
            end
        end,
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = "python",
        keys = {
            {
                "<leader>dm",
                function() require("dap-python").test_method() end,
                desc = "Debug: nearest test method",
            },
            {
                "<leader>dM",
                function() require("dap-python").test_class() end,
                desc = "Debug: test class",
            },
        },
        config = function()
            -- Mason's debugpy only runs the adapter; the program still runs
            -- under the project venv, which dap-python resolves per-config.
            local debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"

            require("dap-python").setup(vim.uv.fs_stat(debugpy) and debugpy or "python3")
            require("dap-python").test_runner = "pytest"
        end,
    },
}
