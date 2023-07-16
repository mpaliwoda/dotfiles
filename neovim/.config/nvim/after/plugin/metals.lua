prequire("metals", function(metals)
    local metals_config = metals.bare_config()

    metals_config.settings = {
        showImplicitArguments = true,
    }

    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt" },
        callback = function()
            require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
    })
end)

