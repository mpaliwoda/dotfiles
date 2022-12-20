prequire("cloak", function(cloak)
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
end)
