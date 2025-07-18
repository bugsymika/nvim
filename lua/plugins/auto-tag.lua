return {
  'windwp/nvim-ts-autotag',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-ts-autotag').setup {
      opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = true, -- Auto close on trailing </
      },
      embedded_html = {
        enable = true,
      },
      per_filetype = {
        ['html'] = {
          enable_close = true,
        },
        ['erb'] = {
          enable_close = true,
        },
        ['eruby'] = {
          enable_close = true,
        },
      },
      aliases = {
        ['eruby'] = 'html',
        ['erb'] = 'html',
      },
    }
  end,
}
