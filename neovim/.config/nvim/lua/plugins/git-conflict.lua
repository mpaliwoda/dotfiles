local present, conflict = pcall(require, 'git-conflict')

if not present then
    return
end

conflict.setup()
