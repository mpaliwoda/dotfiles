return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        {
            "mason-org/mason.nvim",
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
            lazy = true,
            cmd = {
                "Mason",
                "MasonUpdate",
                "MasonInstall",
                "MasonUninstall",
                "MasonUninstallAll",
                "MasonLog",
            },
        },
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
    },
}
