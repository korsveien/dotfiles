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

------------------------
-- LSP + Autocomplete --
------------------------
-- Works best with completeopt=noselect.
-- Use CTRL-Y to select an item. |complete_CTRL-Y|
vim.cmd([[set completeopt+=menuone,noselect,popup]])
vim.lsp.start({
  name = "luals",
  cmd = "luals",
  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item)
        return { abbr = item.label:gsub("%b()", "") }
      end,
    })
  end,
})

-- Use CTRL-space to trigger LSP completion.
-- Use CTRL-Y to select an item. |complete_CTRL-Y|
vim.keymap.set("i", "<c-space>", function()
  vim.lsp.completion.get()
end)

vim.lsp.config["luals"] = {
  -- Command and arguments to start the server.
  cmd = { "lua-language-server" },
  -- Filetypes to automatically attach to.
  filetypes = { "lua" },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  -- Specific settings to send to the server. The schema is server-defined.
  -- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

vim.lsp.enable("luals")

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
