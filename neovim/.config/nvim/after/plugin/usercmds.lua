-- @param command string Git command to run
local function dotfiles_repo_git(command)
    local dots = os.getenv("HOME") .. "/dotfiles"
    os.execute("git -C " .. dots .. " " .. command)
end


vim.api.nvim_create_user_command("UpdatePlugins", function(_)
    -- update plugins via Lazy
    require("lazy").update({ show = true, wait = true, concurrency = 8 })

    -- close Lazy float
    vim.api.nvim_win_close(require("lazy.view").view.win, false)
    vim.notify("Finished updating plugins.")

    local lockfile_updated = dotfiles_repo_git("diff --quiet --exit-code neovim/.config/nvim/lazy-lock.json") ~= 0

    if lockfile_updated then
        vim.notify("Found changes to the lockfile, committing.")
        dotfiles_repo_git("add neovim/.config/nvim/lazy-lock.json")
        dotfiles_repo_git("commit --quiet -m 'auto(nvim): update plugins 😭'")
        dotfiles_repo_git("push --quiet")
    else
        vim.notify("No changes to the lockfile.")
    end
end, { desc = "Update plugins and commit lockfile to repo" })

---
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

vim.api.nvim_create_user_command("PyUpgrade", function(opts)
    if vim.bo.filetype ~= "python" then
        vim.notify("can run pyupgrade only on python files, current buf filetype: " .. vim.bo.filetype)
        return
    end

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
    local result = os.execute("pyupgrade " .. version_opt .. " " .. vim.api.nvim_buf_get_name(0) .. " 2>&1 /dev/null")

    if type(result) == "number" and result ~= 0 then
        vim.notify("Upgraded python, reloading.", vim.log.levels.INFO)
        vim.cmd("checktime")
    else
        vim.notify("No changes needed.")
    end
end, { desc = "Upgrade python to the latest version. Accepts an optional single parameter PYTHON_VER." })


vim.api.nvim_create_user_command(
    "DeleteComments",
    function()
        vim.cmd("%s/" .. vim.fn.substitute(vim.o.commentstring, "%s", ".*$", "g") .. "//")
    end,
    {
        desc = "Delete comments in the current buffer",
    }
)
