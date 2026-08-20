local proc = require("mpaliwoda.utils.process")

local DOTFILES = vim.env.HOME .. "/dotfiles"

--- @param ... string Git arguments to run against the dotfiles repo
--- @return boolean ok, string output
local function dotfiles_repo_git(...)
    return proc.ok({ "git", "-C", DOTFILES, ... })
end

vim.api.nvim_create_user_command("UpdatePlugins", function(_)
    require("lazy").update({ show = true, wait = true, concurrency = 8 })
    vim.api.nvim_win_close(require("lazy.view").view.win, false)
    vim.notify("Finished updating plugins.")

    local lockfile = "neovim/.config/nvim/lazy-lock.json"
    local clean = dotfiles_repo_git("diff", "--quiet", "--exit-code", lockfile)

    if clean then
        vim.notify("No changes to the lockfile.")
        return
    end

    vim.notify("Found changes to the lockfile, committing.")
    dotfiles_repo_git("add", lockfile)
    dotfiles_repo_git("commit", "--quiet", "-m", "auto(nvim): update plugins 😭")
    dotfiles_repo_git("push", "--quiet")
end, { desc = "Update plugins and commit lockfile to repo" })

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

    if vim.fn.executable("pyupgrade") == 0 then
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

        target_ver = raw_ver:gsub('"', "")
    else
        vim.notify("Expected at most a single param: PYTHON_VER, got: " .. vim.inspect(opts.fargs))
        return
    end

    if not validate_python_version(target_ver) then
        vim.notify("Invalid python version: " .. target_ver, vim.log.levels.ERROR)
        return
    end

    local version_opt = format_version_option(target_ver)
    local changed = not proc.ok({ "pyupgrade", version_opt, vim.api.nvim_buf_get_name(0) })

    if changed then
        vim.notify("Upgraded python, reloading.", vim.log.levels.INFO)
        vim.cmd("checktime")
    else
        vim.notify("No changes needed.")
    end
end, { desc = "Upgrade python to the latest version. Accepts an optional single parameter PYTHON_VER." })

vim.api.nvim_create_user_command("DeleteComments", function()
    vim.cmd("%s/" .. vim.fn.substitute(vim.o.commentstring, "%s", ".*$", "g") .. "//")
end, {
    desc = "Delete comments in the current buffer",
})

-- Replaces gitignore.nvim: fetch templates straight from gitignore.io.
local GITIGNORE_API = "https://www.toptal.com/developers/gitignore/api/"

--- @type string[]?
local gitignore_templates

--- @return string[]
local function fetch_gitignore_templates()
    if gitignore_templates then
        return gitignore_templates
    end

    local ok, list = proc.ok({ "curl", "-sfL", GITIGNORE_API .. "list" })

    if not ok then
        vim.notify("Failed to fetch gitignore.io template list.", vim.log.levels.ERROR)
        return {}
    end

    gitignore_templates = vim.split(list:gsub("%s+", ","), ",", { trimempty = true })
    return gitignore_templates
end

vim.api.nvim_create_user_command("Gitignore", function(opts)
    if #opts.fargs == 0 then
        vim.notify("Usage: :Gitignore <template>... (tab-completes)", vim.log.levels.WARN)
        return
    end

    local names = table.concat(opts.fargs, ",")
    local ok, body = proc.ok({ "curl", "-sfL", GITIGNORE_API .. names })

    if not ok then
        vim.notify("Failed to fetch .gitignore for: " .. names, vim.log.levels.ERROR)
        return
    end

    local path = (vim.fs.root(0, ".git") or assert(vim.uv.cwd())) .. "/.gitignore"

    vim.fn.writefile(vim.split(body, "\n"), path)
    vim.notify("Wrote " .. path .. " (" .. names .. ")")
    vim.cmd.edit(path)
end, {
    nargs = "*",
    desc = "Generate a .gitignore from gitignore.io templates",
    complete = function(arg_lead)
        return vim.tbl_filter(function(name)
            return vim.startswith(name, arg_lead)
        end, fetch_gitignore_templates())
    end,
})
