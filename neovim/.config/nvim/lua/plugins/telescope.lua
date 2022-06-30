local present, telescope = pcall(require, "telescope")

if not present then
    return
end

telescope.setup({
    defaults = {
        prompt_prefix = "   ",
        sorting_strategy = "ascending",
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_ignore_patterns = { "node_modules/", ".git/" },
        path_display = { "truncate" },
    },
}
)

local extensions = { "themes", "terms", "coc", "neoclip", "toggletasks" }

for _, ext in ipairs(extensions) do
    pcall(telescope.load_extension, ext)
end
