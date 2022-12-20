local present, headlines = pcall(require, 'headlines')

if not present then
    return
end

headlines.setup()
