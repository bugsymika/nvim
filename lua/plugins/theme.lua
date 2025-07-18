return {
  'folke/tokyonight.nvim',
  priority = 1000,
  opts = {
    on_colors = function(colors)
      colors.bg = '#121212'
    end,
  },
  init = function()
    vim.cmd.colorscheme 'tokyonight'
    vim.cmd.hi 'Comment gui=none'
  end,
}
