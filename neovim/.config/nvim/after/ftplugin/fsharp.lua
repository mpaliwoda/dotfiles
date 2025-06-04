local Menu = require("nui.menu")

vim.api.nvim_create_user_command("FSharpNewFile", function()
    local ionide = vim.lsp.get_clients({ name = "ionide" })

    if #ionide ~= 1 then
        vim.notify("F# LSP is not running")
        return
    end

    ionide = ionide[1]

    vim.cmd([[redir @a]])
    vim.fn["fsharp#showLoadedProjects"]()
    vim.cmd([[redir END]])

    local loaded_projects = vim.fn.getreg("a")

    if loaded_projects == nil then
        vim.notify("No F# projects loaded")
        return
    end

    local menu_items = {}

    for _, project in ipairs(vim.split(loaded_projects, "\n")) do
        if project and project ~= "" then
            local item_name = project:gsub("- ", "", 1)
            table.insert(menu_items, Menu.item(item_name))
        end
    end

    local menu = Menu({
        position = "50%",
        size = { width = 120, height = 10 },
        border = {
            style = "rounded",
            highlight = "FloatBorder",
            text = {
                top = "New F# File",
                top_align = "center",
            },
        },
    }, {
        lines = menu_items,
        keymap = {
            focus_next = { "j", "<Down>", "<Tab>" },
            focus_prev = { "k", "<Up>", "<S-Tab>" },
            close = { "<Esc>", "<C-c>" },
            submit = { "<CR>", "<Space>" },
        },
        on_close = function()
            vim.notify("Aborted")
        end,

        on_submit = function(item)
            local input = vim.fn.input("Enter file name: ", "", "file")

            if not input or input == "" then
                vim.notify("Aborted")
                return
            end

            vim.notify(item.text)
            vim.notify(input)

            ionide.rpc.notify("fsproj/addFile", {
                FsProj = item.text,
                FileVirtualPath = "./" .. input,
            })
        end,
    })

    menu:mount()
end, {})
