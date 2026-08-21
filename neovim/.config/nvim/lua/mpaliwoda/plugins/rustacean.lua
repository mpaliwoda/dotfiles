return {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = "rust",
    dependencies = { "mfussenegger/nvim-dap" },
    init = function()
        -- rustaceanvim reads this global instead of taking a `setup()` call. A
        -- function value is resolved on load, so the `require` below only runs
        -- once the plugin is on the runtimepath.
        vim.g.rustaceanvim = function()
            local ext = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"
            local adapter = ext .. "/adapter/codelldb"
            local liblldb = ext .. "/lldb/lib/liblldb" .. (vim.uv.os_uname().sysname == "Linux" and ".so" or ".dylib")

            return {
                dap = vim.uv.fs_stat(adapter)
                        and { adapter = require("rustaceanvim.config").get_codelldb_adapter(adapter, liblldb) }
                    or {},
                server = {
                    on_attach = function(_, bufnr)
                        vim.keymap.set("n", "<leader>dd", function()
                            vim.cmd.RustLsp({ "debuggables" })
                        end, { buffer = bufnr, remap = false, desc = "Debug: rust debuggables" })
                    end,
                },
            }
        end
    end,
}
