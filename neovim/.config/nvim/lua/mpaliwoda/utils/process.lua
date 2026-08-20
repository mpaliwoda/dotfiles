local M = {}

--- Run a command to completion and return its result.
--- @param cmd string[]
--- @param opts? vim.SystemOpts
--- @return vim.SystemCompleted
M.run = function(cmd, opts)
    return vim.system(cmd, vim.tbl_extend("keep", opts or {}, { text = true })):wait()
end

--- Run a command without blocking. `on_exit` is scheduled on the main loop.
--- @param cmd string[]
--- @param on_exit? fun(out: vim.SystemCompleted)
--- @param opts? vim.SystemOpts
M.spawn = function(cmd, on_exit, opts)
    return vim.system(cmd, vim.tbl_extend("keep", opts or {}, { text = true }), function(out)
        if on_exit then
            vim.schedule(function()
                on_exit(out)
            end)
        end
    end)
end

--- @param cmd string[]
--- @param opts? vim.SystemOpts
--- @return boolean ok, string output
M.ok = function(cmd, opts)
    local out = M.run(cmd, opts)
    return out.code == 0, (out.stdout or "") .. (out.stderr or "")
end

return M
