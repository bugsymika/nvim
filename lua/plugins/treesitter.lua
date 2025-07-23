return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",                     -- ensures parsers are up to date
		event = { "BufReadPost", "BufNewFile" }, -- lazy load
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"typescript",
					"tsx",
					"javascript",
					"ruby",
					"html",
					"css",
					"json",
					"yaml",
					"markdown",
					"bash",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true, disable = { "ruby" } },
				auto_install = true,
			})
		end,
	},
}
