--- @param filename string
--- @param params string[]?
local function git_add(filename, params)
    params = params or {}
    local proc = io.popen("git add " .. filename .. " " .. table.concat(params, " "))

    if not proc then
        vim.notify("unknown err adding file: " .. filename)
        return
    end

    proc:close()
end
