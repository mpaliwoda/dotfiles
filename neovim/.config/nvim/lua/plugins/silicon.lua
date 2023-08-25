prequire("silicon", function(silicon)
	silicon.setup({
		theme = "Monokai Extended",
		output = "./.images/SILICON_${year}-${month}-${date}_${time}.png", -- auto generate file name based on time (absolute or relative to cwd)
		bgColor = '#fff',
		-- bgImage = "", -- path to image, must be png
		roundCorner = true,
		windowControls = true,
		lineNumber = true,
		font = "mononoki Nerd Font",
		-- lineOffset = 1, -- from where to start line number
		linePad = 2, -- padding between lines
		padHoriz = 80, -- Horizontal padding
		padVert = 100, -- vertical padding
		shadowBlurRadius = 30,
		shadowColor = "#555555",
		shadowOffsetX = 8,
		shadowOffsetY = 8,
		gobble = false, -- enable lsautogobble like feature
		debug = true, -- enable debug output
		to_clip = false
	})

	vim.keymap.set("v", "<Leader>l", function()
		silicon.visualise_api({})
	end)
	-- Generate image of a whole buffer, with lines in a visual selection highlighted
	vim.keymap.set("v", "<Leader>k", function()
		silicon.visualise_api({ show_buf = true })
	end)
	-- Generate visible portion of a buffer
	vim.keymap.set("n", "<Leader>9", function()
		silicon.visualise_api({ visible = true })
	end)
	-- Generate current buffer line in normal mode
	vim.keymap.set("n", "<C-0>", function()
		silicon.visualise_api({})
	end)
end)
