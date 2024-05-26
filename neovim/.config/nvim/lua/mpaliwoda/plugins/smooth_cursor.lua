return {
    'gen740/SmoothCursor.nvim',
    opts = {
        type = "exp",
        fancy = {
            enable = true,
            head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
            body = {
                { cursor = "", texthl = "SmoothCursorRed" },
                { cursor = "", texthl = "SmoothCursorOrange" },
                { cursor = "●", texthl = "SmoothCursorYellow" },
                { cursor = "●", texthl = "SmoothCursorGreen" },
                { cursor = "•", texthl = "SmoothCursorAqua" },
                { cursor = ".", texthl = "SmoothCursorBlue" },
                { cursor = ".", texthl = "SmoothCursorPurple" },
            },
            tail = { cursor = nil, texthl = "SmoothCursor" }
        }
    },
}
