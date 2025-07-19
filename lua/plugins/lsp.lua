return {
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"neovim/nvim-lspconfig",
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
						},
					},
				},
				tailwindcss = {
					filetypes = { 'html', 'elixir', 'eelixir', 'heex', 'typescriptreact', 'javascriptreact', 'htmldjango', 'handlebars', 'eruby' },
					init_options = {
						userLanguages = {
							elixir = 'phoenix-heex',
							heex = 'phoenix-heex',
							eruby = 'erb',
						},
					},
				},
				ts_ls = {},
				ruby_lsp = {
					init_options = {
						formatter = "none",
					},
					on_attach = function(client, bufnr)
						-- Disable formatting capability
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end,
				},
			}

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
						require('lspconfig')[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
