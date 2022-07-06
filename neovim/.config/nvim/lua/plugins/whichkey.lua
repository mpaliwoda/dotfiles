local present, whichkey = pcall(require, 'which-key')

if not present then
    return
end

whichkey.register(
    {
        a  = { name = "Debugging" },
        c  = { name = "Coc Telescope" },
        f  = { name = "Fuzzy Finding" },
        g  = { name = "Git" },
        m  = { name = "Coc" },
        r  = { name = "Refactoring" },
        s  = { name = "Search & Replace" },
        t  = { name = "Terminal" },
        tf = { name = "Terminal: Floating" },
        u  = { name = "Undo" },
        i  = { name = "Sort imports" },
        w  = { name = "Tasks" },
    },
    {
        prefix = "<leader>"
    }
)


whichkey.setup()
