local opts = function(cmp)
    return { behavior = cmp.SelectBehavior.Select }
end

local function next_or_indent(cmp)
    local select_opts = opts(cmp)

    local function wrapped(fallback)
        local col = vim.fn.col(".") - 1

        if cmp.visible() then
            cmp.select_next_item(select_opts)
        elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
            fallback()
        else
            cmp.complete()
        end
    end

    return wrapped
end

local function prev_or_dedent(cmp)
    local select_opts = opts(cmp)

    local function wrapped(fallback)
        if cmp.visible() then cmp.select_prev_item(select_opts) else fallback() end
    end

    return wrapped
end

local function jump_or_fallback(luasnip, step)
    local function wrapped(fallback)
        if luasnip.jumpable(step) then luasnip.jump(step) else fallback() end
    end

    return wrapped
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "dcampos/cmp-emmet-vim",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",

        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",

        "onsails/lspkind.nvim",

        "windwp/nvim-autopairs",
        "luckasRanarison/tailwind-tools.nvim",
    },
    event = 'InsertEnter',
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local autopairs = require("nvim-autopairs")
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')

        autopairs.setup({
            disable_filetype = {
                "TelescopePrompt",
                "vim",
            },
        })

        cmp.setup({
            sources = {
                { name = "nvim_lsp",               keyword_length = 1 },
                { name = "nvim_lsp_signature_help" },
                { name = "luasnip" },
                { name = "emmet_vim" },
                { name = "path" },
                { name = "emoji" },
                { name = "buffer",                 keyword_length = 3 },
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                format = lspkind.cmp_format({
                    before = require("tailwind-tools.cmp").lspkind_format
                })
            },
            mapping = {
                ["<Up>"] = cmp.mapping.select_prev_item(opts(cmp)),
                ["<Down>"] = cmp.mapping.select_next_item(opts(cmp)),
                ["<C-p>"] = cmp.mapping.select_prev_item(opts(cmp)),
                ["<C-n>"] = cmp.mapping.select_next_item(opts(cmp)),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-g>"] = cmp.mapping.close(),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<Tab>"] = cmp.mapping(next_or_indent(cmp), { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(prev_or_dedent(cmp), { "i", "s" }),

                ["<M-f>"] = cmp.mapping(jump_or_fallback(luasnip, 1), { "i", "s" }),
                ["<M-b>"] = cmp.mapping(jump_or_fallback(luasnip, -1), { "i", "s" }),
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
        })

        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
    end
}
