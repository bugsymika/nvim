return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mason.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")

		local format_augroup = vim.api.nvim_create_augroup("LspFormat", { clear = true })

		local erb_format = {
			name = "erb-formatter",
			method = null_ls.methods.FORMATTING,
			filetypes = { "eruby" },
			generator = null_ls.generator({
				command = "bundle",
				args = {
					"exec", "erb-format",
					"--stdin-filename", "$FILENAME",
				},
				to_stdin = true,
				from_stderr = true,
			}),
		}
		null_ls.setup({
			sources = {
				-- JS/TS/HTML/etc.
				null_ls.builtins.formatting.prettier,
				-- Lua
				null_ls.builtins.formatting.stylua,
				-- ✅ Reliable Ruby formatter
				null_ls.builtins.formatting.rubocop.with({
					command = "bundle",
					args = {
						"exec",
						"rubocop",
						"--auto-correct",
						"--stdin",
						"$FILENAME",
						"-f", "quiet",
						"--stderr",
					},
					to_stdin = true,
					filetypes = { "ruby" },
				}),
				null_ls.builtins.diagnostics.rubocop.with({ -- 💥 diagnostics added
					command = "bundle",
					args = {
						"exec",
						"rubocop",
						"--format", "json",
						"--force-exclusion",
						"--stdin", "$FILENAME",
					},
					to_stdin = true,
					filetypes = { "ruby" },
				}),
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = format_augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
	end,
}
