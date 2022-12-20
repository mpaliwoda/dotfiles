local present, sniprun = pcall(require, 'sniprun')

if not present then
    return
end

sniprun.setup({
    display = {
        'VirtualTextOk',
        'NvimNotifyErr',
    },
    live_mode_toggle = 'on',
})
