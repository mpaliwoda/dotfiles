local present, telescope = pcall(require, "telescope")

if not present then
    return
end

telescope.setup({
    defaults = {
        prompt_prefix        = "   ",
        sorting_strategy     = "ascending",
        file_sorter          = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules/", ".git/" },
        path_display         = { "truncate" },
        layout_config        = {
            horizontal     = {
                prompt_position = "top",
                preview_width   = 0.55,
                results_width   = 0.8,
            },
            vertical       = {
                mirror = false,
            },
            width          = 0.87,
            height         = 0.80,
            preview_cutoff = 120,
        },
        mappings             = {
            n = {
                ["<M-w>"] = require("telescope.actions").delete_buffer
            },
            i = {
                ["<M-w>"] = require("telescope.actions").delete_buffer,
                ['<M-p>'] = require('telescope.actions.layout').toggle_preview,
            }
        }
    },
}
)

local extensions = {
    "coc",
    "file_browser",
    "neoclip",
    "noice",
    "notify",
    "terms",
    "themes",
    "toggletasks",
}

for _, ext in ipairs(extensions) do
    pcall(telescope.load_extension, ext)
end
