return {
    "ionide/Ionide-vim",
    opts = {},
    ft = { "fsharp" },
    init = function()
        vim.g["fsharp#lsp_auto_setup"] = 0
        vim.g["fsharp#workspace_mode_peek_deep_level"] = 3
    end,
}
