---@type fun(module_name: string, callback: fun(module: table)): nil
function prequire(module_name, callback)
    local present, module = pcall(require, module_name)

    if not present then
        vim.notify("Module " .. module_name .. " not installed. Run `PlugInstall`.", "error")
        return
    end

    callback(module)
end
