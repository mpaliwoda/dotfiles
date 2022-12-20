prequire("toggletasks", function(toggletasks)
    toggletasks.setup({
        search_paths = {
            'tasks',
            '.tasks',
            '.vscode/tasks',
        },
        scan = {
            dirs = {
                os.getenv("HOME") .. '/.config/nvim',
            }
        }
    })
end)
