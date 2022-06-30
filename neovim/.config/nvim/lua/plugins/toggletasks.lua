local present, toggletasks = pcall(require, 'toggletasks')

if not present then
    return
end


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
