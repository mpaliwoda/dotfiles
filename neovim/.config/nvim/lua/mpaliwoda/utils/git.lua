local M = {}

--- @param filename string
--- @param params string[]?
M.add = function(filename, params)
    params = params or {}
    local proc = io.popen("git add " .. filename .. " " .. table.concat(params, " "))

    if not proc then
        vim.notify("unknown err adding file: " .. filename)
        return
    end

    proc:close()
end

return M
