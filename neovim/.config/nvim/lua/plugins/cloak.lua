local present, cloak = pcall(require, 'cloak')

if not present then
    return
end

cloak.setup({
    enabled = true,
    patterns = {
        {
            file_pattern = '.env*',
            cloak_pattern = '=.+'
        },
        {
            file_pattern = '*.env',
            cloak_pattern = '=.+'
        },
    }
})
