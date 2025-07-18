vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

 require("config.options")  -- optional: your vim.opt settings
require("config.remap")    -- your keymaps (like <leader> bindings)
require("config.commands")
require("config.lazy")

