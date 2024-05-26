return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-fzf-native.nvim",
    },
    keys = {
        { "<Leader>ff", "<cmd>Telescope find_files hidden=true<cr>" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
        { "<leader>ft", "<cmd>Telescope file_browser<cr>" },
        { "<leader>fp", "<cmd>Telescope git_files<cr>" },
        { "<leader>fp", "<cmd>Telescope git_files<cr>" },
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
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
            extensions = {
                file_browser = {
                    theme = "ivy",
                    hijack_netrw = true,
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            }
        })

        local extensions = {
            "fzf",
            "notify",
            "file_browser",
        }

        for ext in ipairs(extensions) do
            pcall(telescope.load_extension, ext)
        end
    end,
}
