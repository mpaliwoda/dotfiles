prequire("goto-preview", function(preview)
    preview.setup()

    vim.keymap.set("n", "<leader>pd", preview.goto_preview_definition)
    vim.keymap.set("n", "<leader>ptd", preview.goto_preview_type_definition)
    vim.keymap.set("n", "<leader>pe", preview.goto_preview_implementation)
    vim.keymap.set("n", "<leader>pp", preview.close_all_win)
end)
