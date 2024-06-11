--- @param version_string string
local validate_python_version = function(version_string)
    if version_string:match("3%.[6789]") then
        return true
    elseif version_string:match("3%.1[012]") then
        return true
    else
        return false
    end
end

--- @param version_string string
local format_version_option = function(version_string)
    local normalized_version = version_string:gsub("%.", "")
    return "--py" .. normalized_version .. "-plus"
end

vim.api.nvim_buf_create_user_command(0, "PyUpgrade", function(opts)
    local has_pyupgrade = os.execute("which -s pyupgrade")

    if type(has_pyupgrade) ~= "number" or has_pyupgrade ~= 0 then
        vim.notify(
            "Oopsie!\n\nmissing pyupgrade, you can install it by running:\n\n\tpipx install pyupgrade",
            vim.log.levels.WARN
        )
        return
    end

    local target_ver

    if #opts.fargs == 0 then
        target_ver = "3.12"
    elseif #opts.fargs == 1 then
        local raw_ver = opts.fargs[1]

        if type(raw_ver) ~= "string" then
            vim.notify(
                "Malformed version param: " .. vim.inspect(raw_ver) .. " (type: " .. type(raw_ver) .. ")",
                vim.log.levels.ERROR
            )
            return
        end

        target_ver = raw_ver:gsub('\"', "")
    else
        vim.notify("Expected at most a single param: PYTHON_VER, got: " .. vim.inspect(opts.fargs))
    end

    if not validate_python_version(target_ver) then
        vim.notify("Invalid python version: " .. target_ver, vim.log.levels.ERROR)
        return
    end

    local version_opt = format_version_option(target_ver)
    local result = os.execute("pyupgrade " .. version_opt .. " " .. vim.api.nvim_buf_get_name(0) .. "2>&1 /dev/null")

    if type(result) == "number" and result ~= 0 then
        vim.notify("Upgraded python, reloading.", vim.log.levels.INFO)
        vim.cmd("checktime")
    else
        vim.notify("No changes needed.")
    end
end, { desc = "Upgrade python to the latest version. Accepts an optional single parameter PYTHON_VER." })
