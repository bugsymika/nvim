return {
	'akinsho/bufferline.nvim',
	version = '*',
	dependencies = 'nvim-tree/nvim-web-devicons',
	opts = {},
	init = function()
		vim.keymap.set('n', '<C-q>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true })
		vim.keymap.set('n', '<C-e>', '<Cmd>BufferLineCycleNext<CR>', { silent = true })

		vim.keymap.set('n', '<C-1>', ':BufferLineMovePrev<CR>', { silent = true })
		vim.keymap.set('n', '<C-3>', ':BufferLineMoveNext<CR>', { silent = true })

		vim.keymap.set('n', '<C-w>', '<Cmd>bdelete<CR>', { silent = true })
	end,
}
