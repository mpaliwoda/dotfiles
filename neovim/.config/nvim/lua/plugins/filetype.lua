local present, filetype = pcall(require, 'filetype')

if not present then
    return
end

--empty table is required unlike in other plugins
filetype.setup({})
