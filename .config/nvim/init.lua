-------------
-- PRELUDE --
-------------

-- Set leader before any plugins are loaded
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw as advised by nvim-tree plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-------------
-- PLUGINS --
-------------

require("config.pluginmanager")
require("config.statusline")

--------------
-- VIM OPTS --
--------------

vim.opt.clipboard = "unnamedplus"
vim.opt.hidden = true -- switch between buffers without saving changes
vim.opt.laststatus = 3 -- global statusline
vim.opt.number = true -- show line numbers
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.swapfile = true
vim.opt.wrap = false
vim.opt_local.conceallevel = 2

-----------------
-- KEYBINDINGS --
-----------------

-- Convenvience
vim.keymap.set("n", "<C-q>", "<Cmd>quit!<CR>")
vim.keymap.set("n", "<leader>j", "<Cmd>set ft=json<CR>") -- Set filetype to json
vim.keymap.set("n", "<leader>s", "<Cmd>source %<CR>") -- Source the current file
vim.keymap.set("v", "<leader>y", '"+y') -- Copy to clipboard

-- Picker
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<C-f>", telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<C-S-f>", telescope.grep_string, { desc = "Search for word under cursor" })
vim.keymap.set("n", "<C-e>", telescope.buffers, { desc = "Telescope buffers" })

-- File Tree
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTreeToggle<CR>")

-------------------
--  AUTOCOMMANDS --
-------------------

-- Open help window in a vertical split
vim.cmd([[autocmd FileType help wincmd L]])

-- For my fat fingers
vim.cmd([[cab W write]])
vim.cmd([[cab, Q, "quit"]])

-- きれいね
vim.cmd("colorscheme kanagawa-dragon")
