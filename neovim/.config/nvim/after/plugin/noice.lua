prequire("noice", function(noice)
    noice.setup({
        lsp = {
            signature = { enabled = true, view = "virtualtext" },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = false,
            command_palette = true,
            long_message_to_split = true,
            lsp_doc_border = true,
            inc_rename = true,
        },
    })
end)
