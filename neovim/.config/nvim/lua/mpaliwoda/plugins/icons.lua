return {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
        -- lualine / markview / leetcode still ask for nvim-web-devicons
        package.preload["nvim-web-devicons"] = function()
            require("mini.icons").mock_nvim_web_devicons()
            return package.loaded["nvim-web-devicons"]
        end
    end,
}
