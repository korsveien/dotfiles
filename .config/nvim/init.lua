-- Set leader before any plugins are loaded
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw as advised by nvim-tree plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.copilot_filetypes = { markdown = false }

require("config.options")
require("config.pluginmanager")
require("config.keybindings")
require("config.autocommands")
require("config.statusline")

vim.cmd("colorscheme kanagawa-dragon")
