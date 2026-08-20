local mason_bin = vim.env.HOME .. "/.local/share/nvim/mason/bin/"

return {
    filetypes = { "sh", "bash", "zsh" },
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
            enableSourceErrorDiagnostics = true,
            includeAllWorkspaceSymbols = true,
            shellcheckPath = mason_bin .. "shellcheck",
            shfmt = {
                path = mason_bin .. "shfmt",
                caseIndent = true,
                simplifyCode = true,
                binaryNextLine = true,
            },
        },
    },
}
