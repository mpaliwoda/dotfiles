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
                    border = "rounded",
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
        ensure_installed = {
            "bashls",
            "basedpyright",
            "emmet_ls",
            "html",
            "jsonls",
            "lua_ls",
            "ts_ls",
            "yamlls",
        },
    },
}
