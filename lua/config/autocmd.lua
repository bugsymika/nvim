vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch", -- or any highlight group you prefer
			timeout = 200,      -- duration in milliseconds
		})
	end,
})
