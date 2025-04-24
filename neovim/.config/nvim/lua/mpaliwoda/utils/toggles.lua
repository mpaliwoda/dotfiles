local M = {}

M._toggles = {}

---@alias Mode "n" | "v" | "i" | "t"
---@class ToggleState
---@field name string Name of the toggle
---@field active boolean Current state of the toggle
---@field keybinds table<Mode, string> Table of keybindings for each mode
---@field toggled fun(): nil Current state of the toggle
---@field untoggled fun(): nil Current state of the toggle
---@param toggle ToggleState
M.create = function(toggle)
    local state_changed = function()
        if not M._toggles[toggle.name].active then
            M._toggles[toggle.name].toggled()
        else
            M._toggles[toggle.name].untoggled()
        end
    end


    local change_state = function()
        M._toggles[toggle.name].active = not M._toggles[toggle.name].active
        state_changed()
    end

    for mode, lhs in pairs(toggle.keybinds) do
        vim.keymap.set(mode, lhs, change_state, { buffer = false })
    end

    M._toggles[toggle.name] = toggle
    state_changed()
end


---@param toggle ToggleState
M.repr = function(toggle)
    return "name    : " .. toggle.name .. "\n" ..
        "active  : " .. vim.inspect(toggle.active) .. "\n" ..
        "keybinds: " .. vim.inspect(toggle.keybinds)
end

vim.api.nvim_create_user_command("ListToggles", function()
    local printable = ""

    for _, toggle in pairs(M._toggles) do
        printable = printable .. "\n---\n" .. M.repr(toggle)
    end

    vim.notify(printable)
end, {})

return M
