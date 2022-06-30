local present, toggletasks = pcall(require, 'toggletasks')

if not present then
    return
end


toggletasks.setup()
