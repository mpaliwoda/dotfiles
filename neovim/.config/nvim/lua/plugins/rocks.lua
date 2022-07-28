local present, rocks = pcall(require, "nvim_rocks")

if not present then
    return
end

rocks.ensure_installed("reactivex")
