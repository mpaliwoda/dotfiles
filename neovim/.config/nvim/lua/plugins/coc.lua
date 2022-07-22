vim.g.coc_global_extensions = {
    "coc-css",
    "coc-db",
    "coc-emmet",
    "coc-emoji",
    "coc-format-json",
    "coc-go",
    "coc-html",
    "coc-htmldjango",
    "coc-json",
    "coc-marketplace",
    "coc-prettier",
    "coc-pyright",
    "coc-rust-analyzer",
    "coc-sh",
    "coc-solargraph",
    "coc-sql",
    "coc-sqlfluff",
    "coc-sumneko-lua",
    "coc-tailwindcss",
    "coc-toml",
    "coc-tsserver",
    "coc-yaml",
}

vim.fn["coc#config"]("diagnostic.errorSign", "💥")
vim.fn["coc#config"]("diagnostic.warningSign", "💣")
