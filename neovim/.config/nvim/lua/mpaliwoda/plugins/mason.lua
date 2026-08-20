return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        {
            "mason-org/mason.nvim",
            cmd = {
                "Mason",
                "MasonUpdate",
                "MasonInstall",
                "MasonUninstall",
                "MasonUninstallAll",
                "MasonLog",
            },
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            },
        },
    },
    opts = {
        -- Servers are enabled explicitly in `plugins/lsp.lua`.
        automatic_enable = false,
        ensure_installed = {
            "bashls",
            "basedpyright",
            "cssls",
            "emmet_ls",
            "html",
            "jdtls",
            "jsonls",
            "lua_ls",
            "tailwindcss",
            "ts_ls",
            "yamlls",
        },
    },
}
