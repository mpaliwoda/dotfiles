local present, glow = pcall(require, "glow")

if not present then
    return
end

glow.setup({
    width = 180
})
