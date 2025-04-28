local M = {}

--- @param cmd string
--- @param ... string
--- @return string?
M.run = function(cmd, ...)
    cmd = table.concat({ cmd, ... }, " ")

    local proc = io.popen(cmd)

    if not proc then
        vim.notify("Failed to run command: " .. cmd)
        return
    end

    local out = proc:read("*a")
    proc:close()

    return out
end

return M
