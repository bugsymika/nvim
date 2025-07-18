return {
  'stevearc/oil.nvim',
  opts = {
    delete_to_trash = true,
    view_options = {
      is_hidden_file = function(name, bufnr)
        local templgo = vim.endswith(name, 'templ.go')
        local templtxt = vim.endswith(name, 'templ.txt')
        local hide = templgo or templtxt
        print(name, templgo, templtxt, hide)

        return hide
      end,
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
