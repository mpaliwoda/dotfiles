-- DAP CONFIG
prequire("dap", function(dap)
    dap.adapters.typescript = {
        type = 'executable',
        command = 'ts-node',
        args = { os.getenv('HOME') .. '/repos/vscode-node-debug2/out/src/nodeDebug.js', '--esm' }
    }

    dap.configurations.typescript = {
        {
            type = 'typescript',
            request = 'launch',
            name = 'Launch program (node2 with ts-node)',
            cwd = vim.fn.getcwd(),
            runtimeArgs = { '-r', 'ts-node/register' },
            args = { '--inspect', '${file}' },
            sourceMaps = true,
            skipFiles = { '<node_internal>/**', 'node_modules/**' },
        },
        {
            type = 'typescript',
            request = 'attach',
            name = 'Attatch to program (node2 with ts-node)',
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            skipFiles = { '<node_internal>/**' },
            port = 9229,
        },
        {
            type = 'typescript',
            request = 'launch',
            name = 'Launch test (node2 with ts-node)',
            cwd = vim.fn.getcwd(),
            runtimeArgs = { '--inspect-brk', '${workspaceFolder}/node_modules/.bin/jest' },
            runtimeExecutable = 'node',
            args = { '${file}', '--runInBand', '--coverage', 'false' },
            sourceMaps = true,
            port = 9229,
            skipFiles = { '<node_internal>/**', 'node_modules/**' },
        },
    }


    local api = vim.api
    local keymap_restore = {}

    dap.listeners.after['event_initialized']['me'] = function()
        for _, buf in pairs(api.nvim_list_bufs()) do
            local keymaps = api.nvim_buf_get_keymap(buf, 'n')
            for _, keymap in pairs(keymaps) do
                if keymap.lhs == "K" then
                    table.insert(keymap_restore, keymap)
                    api.nvim_buf_del_keymap(buf, 'n', 'K')
                end
            end
        end
        api.nvim_set_keymap(
            'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
    end

    dap.listeners.after['event_terminated']['me'] = function()
        for _, keymap in pairs(keymap_restore) do
            api.nvim_buf_set_keymap(
                keymap.buffer,
                keymap.mode,
                keymap.lhs,
                keymap.rhs,
                { silent = keymap.silent == 1 }
            )
        end
        keymap_restore = {}
    end

    vim.fn.sign_define("DapBreakpoint", { text = "⬢", texthl = "Yellow", linehl = "", numhl = "Yellow" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Green", linehl = "ColorColumn", numhl = "Green" })

    -- DAP UI
    prequire("dapui", function(dap_ui)
        dap_ui.setup({
            icons = { expanded = "▾", collapsed = "▸" },
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            -- Expand lines larger than the window
            -- Requires >= 0.7
            expand_lines = vim.fn.has("nvim-0.7"),
            layouts = {
                {
                    elements = {
                        'scopes',
                        'breakpoints',
                        'stacks',
                        'watches',
                    },
                    size = 40,
                    position = 'left',
                },
                {
                    elements = {
                        'repl',
                        'console',
                    },
                    size = 10,
                    position = 'bottom',
                },
            },
            floating = {
                max_height = nil, -- These can be integers or a float between 0 and 1.
                max_width = nil, -- Floats will be treated as percentage of your screen.
                border = "single", -- Border style. Can be "single", "double" or "rounded"
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil, -- Can be integer or nil.
            }
        })

        -- open on dap startup
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dap_ui.open()
        end

        dap.listeners.before.event_terminated["dapui_config"] = function()
            dap_ui.close()
        end

        dap.listeners.before.event_exited["dapui_config"] = function()
            dap_ui.close()
        end
    end)
end)


-- DAP VIRTUALTEXT
prequire("nvim-dap-virtual-text", function(dap_vtext)
    dap_vtext.setup()
end)


-- DAP PYTHON CONFIG
prequire("dap-python", function(dap_python)
    dap_python.test_runner = "pytest"
    dap_python.setup('/Users/marcin.paliwoda/.pyenv/versions/neovim3/bin/python3')
end)
