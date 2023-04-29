prequire("venv-selector", function (venv)
    venv.setup({
        changed_venv_hooks = {
            venv.hooks.pylsp,
        }
    })
end)
