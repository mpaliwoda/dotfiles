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
    "@yaegassy/coc-marksman"
}


local set_config = vim.fn["coc#config"]

set_config("floatFactory.floatConfig", { rounded = true, border = true })
set_config("suggest.floatConfig", { rounded = true, border = true })

set_config("diagnostic.errorSign", "💥")
set_config("diagnostic.warningSign", "💣")
set_config("diagnostic.checkCurrentLine", true)
set_config("diagnostic.virtualText", true)
set_config("diagnostic.virtualTextCurrentLineOnly", false)

set_config("python.formatting.provider", "black")
set_config("python.formatting.blackPath", os.getenv("HOME") .. "/.pyenv/versions/neovim3/bin/black")
set_config("python.formatting.blackArgs", { "--line-length", "120" })

set_config("python.linting.mypyEnabled", true)
set_config("python.linting.mypyArgs",
    { "--ignore-missing-imports", "--python-version=3.10", "--exclude=tests/", "--exclude=alembic/", "--exclude=logger*" })

set_config("python.linting.flake8Enabled", true)
set_config("python.linting.flake8Path", os.getenv("HOME") .. "/.pyenv/versions/neovim3/bin/flake8")
set_config("python.linting.flake8Args", { "--ignore=N802,E203,W503,W504", "--max-line-length=120" })

set_config("pyright.organizeimports.provider", "isort")
set_config("python.sortImports.path", os.getenv("HOME") .. "/.pyenv/versions/neovim3/bin/isort")
set_config("python.sortImports.args", { "--settings-path", os.getenv("HOME") .. "/.isort.cfg", "--src", "." })

set_config("pyright.disableDiagnostics", true)
set_config("pyright.inlayHints.enable", true)
set_config("pyright.inlayHints.variableTypes", true)
set_config("pyright.completion.importSupport", true)
set_config("pyright.completion.snippetSupport", true)
set_config("python.linting.pylintEnabled", false)

set_config("solargraph.formatting", true)

set_config("htmldjango.djlint.profile", "jinja")
set_config("htmldjango.formatting.provider", "djlint")
set_config("htmldjango.djlint.enableLint", true)

set_config("emmet.includeLanguages", { htmldjango = "html" })
set_config("emmet.priority", 100)
set_config("tailwindCSS.headwind.runOnSave", false)
set_config("typescript.inlayHints.parameterTypes.enabled", true)

set_config("Lua.telemetry.enable", false)
set_config("Lua.hint.paramName", "All")
set_config("Lua.hint.arrayIndex", "Enable")

set_config("coc.source.emoji.filetypes", { "html", "htmldjango", "markdown", "gitcommit" })

set_config("codeLens.enable", true)
set_config("coc.preferences.enableMessageDialog", true)
