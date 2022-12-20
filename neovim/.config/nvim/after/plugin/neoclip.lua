local present, neoclip = pcall(require, 'neoclip')

if not present then
    return
end

neoclip.setup({
    enable_persistent_history = true,
    history = 50,
})
