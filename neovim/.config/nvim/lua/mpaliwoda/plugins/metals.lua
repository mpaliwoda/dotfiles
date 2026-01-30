return {
    "scalameta/nvim-metals",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    init = function()
        vim.opt_global.shortmess:remove("F")
    end,
    opts = function()
        local config = require("metals").bare_config()

        config.settings = {
            showImplicitArguments = true,
            showImplicitConversionsAndClasses = true,
            showInferredType = true,
            superMethodLensesEnabled = true,
            enableSemanticHighlighting = true,
            inlayHints = {
                hintsInPatternMatch = { enable = true },
                implicitArguments = { enable = true },
                implicitConversions = { enable = true },
                inferredTypes = { enable = true },
                typeParameters = { enable = true },
            },
            excludedPackages = {
                "akka.actor.typed.javadsl",
                "com.github.swagger.akka.javadsl",
            },
        }

        config.init_options = {
            statusBarProvider = "on",
        }

        config.capabilities = require("blink.cmp").get_lsp_capabilities()

        config.on_attach = function(client, bufnr)
            if vim.lsp.inlay_hint then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
        end

        return config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end,
}
