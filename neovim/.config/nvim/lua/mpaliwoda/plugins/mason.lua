return {
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
    dependencies = {
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                ensure_installed = {
                    "bashls",
                    "basedpyright",
                    "emmet_ls",
                    "gopls",
                    "html",
                    "jsonls",
                    "lua_ls",
                    "ts_ls",
                    "yamlls",
                },
            },
        },
    },
}
