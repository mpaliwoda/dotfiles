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
