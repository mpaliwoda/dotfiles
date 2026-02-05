return {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
        { "saghen/blink.compat", version = "2.*", lazy = true, opts = {} },
        { "hrsh7th/cmp-emoji", lazy = true },
        { "dcampos/cmp-emmet-vim", lazy = true },
        { "rafamadriz/friendly-snippets", lazy = true },
        { "luckasRanarison/tailwind-tools.nvim", lazy = true },
    },
    event = "InsertEnter",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        completion = {
            trigger = {
                show_on_insert = false,
                show_on_keyword = true,
                show_on_trigger_character = true,
                show_on_blocked_trigger_characters = { " ", "\n", "\t" },
            },

            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },

            menu = {
                border = "rounded",
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local item = ctx.item
                                if item.kind == require("blink.cmp.types").CompletionItemKind.Color then
                                    local color = item.documentation
                                    if color and color:match("^#%x%x%x%x%x%x$") then
                                        return "██"
                                    end
                                end
                                return ctx.kind_icon
                            end,
                            highlight = function(ctx)
                                local item = ctx.item
                                if item.kind == require("blink.cmp.types").CompletionItemKind.Color then
                                    local color = item.documentation
                                    if color and color:match("^#%x%x%x%x%x%x$") then
                                        -- Create highlight group for this color
                                        local hl_name = "BlinkCmpColor" .. color:sub(2)
                                        if vim.fn.hlexists(hl_name) == 0 then
                                            vim.api.nvim_set_hl(0, hl_name, { fg = color })
                                        end
                                        return hl_name
                                    end
                                end
                                return "BlinkCmpKind" .. ctx.kind
                            end,
                        },
                    },
                },
            },

            documentation = {
                auto_show = true,
                window = {
                    border = "rounded",
                },
            },

            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
        },

        signature = {
            enabled = true,
            window = {
                border = "rounded",
            },
        },

        snippets = {
            preset = "default",
        },

        sources = {
            default = { "lsp", "snippets", "emmet", "path", "emoji", "buffer" },

            providers = {
                lsp = {
                    name = "LSP",
                    module = "blink.cmp.sources.lsp",
                    min_keyword_length = 0,
                    score_offset = 100,
                    fallbacks = { "buffer" },
                },
                snippets = {
                    name = "Snippets",
                    module = "blink.cmp.sources.snippets",
                    min_keyword_length = 2,
                    score_offset = -100,
                },
                path = {
                    name = "Path",
                    module = "blink.cmp.sources.path",
                    score_offset = 0,
                },
                buffer = {
                    name = "Buffer",
                    module = "blink.cmp.sources.buffer",
                    min_keyword_length = 3,
                    score_offset = -3,
                },
                -- nvim-cmp sources via blink.compat
                emoji = {
                    name = "emoji",
                    module = "blink.compat.source",
                    min_keyword_length = 2,
                    score_offset = -2,
                },
                emmet = {
                    name = "emmet_vim",
                    module = "blink.compat.source",
                    score_offset = 1,
                },
            },
        },

        keymap = {
            preset = "none",
            -- Navigation
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            -- Scroll docs
            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            -- Cancel/close
            ["<C-e>"] = { "cancel", "fallback" },
            ["<C-g>"] = { "cancel", "fallback" },
            -- Confirm: C-y auto-selects first if nothing selected
            ["<C-y>"] = { "select_and_accept", "fallback" },
            -- Confirm: CR only confirms if explicitly selected
            ["<CR>"] = { "accept", "fallback" },
            -- Manual trigger
            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            -- Tab: your custom behavior - only complete if non-whitespace before cursor
            ["<Tab>"] = {
                function(cmp)
                    if cmp.is_visible() then
                        return cmp.select_next()
                    end

                    local col = vim.fn.col(".") - 1
                    if col == 0 then
                        return false -- fallback to normal tab
                    end

                    local line = vim.fn.getline(".")
                    local char_before = line:sub(col, col)
                    if char_before:match("%s") then
                        return false -- fallback to normal tab
                    end

                    return cmp.show()
                end,
                "fallback",
            },

            ["<S-Tab>"] = {
                function(cmp)
                    if cmp.is_visible() then
                        return cmp.select_prev()
                    end
                    return false
                end,
                "fallback",
            },

            -- Snippet navigation (Alt-f/Alt-b like your config)
            ["<M-f>"] = { "snippet_forward", "fallback" },
            ["<M-b>"] = { "snippet_backward", "fallback" },
        },
    },

}
