---@type fun(module_name: string, callback: fun(module: table)): nil
function prequire(module_name, callback)
    if type(module_name) ~= "string" then
        vim.notify("Incorrect module_name type. Expected: string, got: " .. type(module_name), "error")
        return
    end

    if type(callback) ~= "function" then
        vim.notify("Incorrect callback type. Expected: function, got: " .. type(callback), "error")
        return
    end

    local present, module = pcall(require, module_name)

    if not present then
        vim.notify("Module " .. module_name .. " not installed. Run `PlugInstall`.", "error")
        return
    end

    callback(module)
end
