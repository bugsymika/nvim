return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			winopts = {
				preview = { layout = "vertical" },
			},
		})

		-- 🧠 Track last used picker and rebind keys
		local fzf = require("fzf-lua")
		local last_picker = nil

		local function track(picker)
			last_picker = picker
			fzf[picker]()
		end

		local function repeat_last()
			if last_picker then
				fzf[last_picker]()
			else
				vim.notify("No previous FZF picker", vim.log.levels.WARN)
			end
		end

		-- 🔑 Keymaps
		vim.keymap.set("n", "<leader>ff", function() track("files") end, { desc = "FZF: Files" })
		vim.keymap.set("n", "<leader>fg", function() track("live_grep") end, { desc = "FZF: Grep" })
		vim.keymap.set("n", "<leader>fb", function() track("buffers") end, { desc = "FZF: Buffers" })
	end,
}
