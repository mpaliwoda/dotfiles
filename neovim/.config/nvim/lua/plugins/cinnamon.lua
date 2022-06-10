local present, cinnamon  = pcall(require, 'cinnamon')

if not present then
    return
end

cinnamon.setup()
