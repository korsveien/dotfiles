-- Convenvience
vim.keymap.set("n", "<C-q>", "<Cmd>quit!<CR>")
vim.keymap.set("n", "<leader>j", "<Cmd>set ft=json<CR>") -- Set filetype to json
vim.keymap.set("n", "<leader>s", "<Cmd>source %<CR>") -- Source the current file
vim.keymap.set("v", "<leader>y", '"+y') -- Copy to clipboard

-- Picker
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<C-f>", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<C-S-f>", builtin.grep_string, { desc = "Search for word under cursor" })
vim.keymap.set("n", "<C-e>", builtin.buffers, { desc = "Telescope buffers" })

-- File Tree
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTreeToggle<CR>")

-- CodeCompanion
vim.keymap.set({ "n", "v", "i" }, "<Leader>a", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<C-/>", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
