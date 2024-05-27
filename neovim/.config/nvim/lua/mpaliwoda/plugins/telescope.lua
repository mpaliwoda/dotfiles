return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
                defaults = {
                    prompt_prefix        = "   ",
                    sorting_strategy     = "ascending",
                    file_sorter          = require("telescope.sorters").get_fuzzy_file,
                    -- file_ignore_patterns = { "node_modules/", ".git/" },
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
                        follow_symlinks = true,
                        respect_gitignore = true,
                        hidden = {
                            file_browser = true,
                            folder_browser = true,
                        },
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                }
            })

            vim.keymap.set("n", "<Leader>ff", "<cmd>Telescope find_files hidden=true<cr>")
            vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
            vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
            vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
            vim.keymap.set("n", "<leader>fp", "<cmd>Telescope git_files<cr>")
            vim.keymap.set("n", "<leader>diag", "<cmd>Telescope diagnostics<cr>")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "CFLAGS=-march=native make",
        lazy = true,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").load_extension("fzf")
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").load_extension("file_browser")

            vim.keymap.set("n", "<leader>ft", "<cmd>Telescope file_browser initial_mode=normal hidden=true<cr>")
        end
    }
}
