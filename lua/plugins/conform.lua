return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 500,
		},
		formatters_by_ft = {
			eruby = { "erb_formatter" },
		},
		formatters = {
			erb_formatter = {
				command = "erb-format",
				args = { "--stdin-filename", "$FILENAME" },
				stdin = true,
			},
		},
	},
}
