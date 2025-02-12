-- Convenvience
vim.keymap.set("n", "<C-q>", "<Cmd>quit!<CR>")
vim.keymap.set("n", "<leader>j", "<Cmd>set ft=json<CR>") -- Set filetype to json
vim.keymap.set("n", "<leader>s", "<Cmd>source %<CR>") -- Source the current file
vim.keymap.set("v", "<leader>y", '"+y') -- Copy to clipboard

-- For fat fingers

-- Picker
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", "<Cmd>Telescope find_files<CR>")

-- Search for a string in current directory
vim.keymap.set("n", "<C-f>", "<Cmd>Telescope live_grep<CR>")

-- Search for the word under the cursor
vim.keymap.set("n", "<C-S-f>", "<Cmd>Telescope grep_string<CR>")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- File Tree
vim.keymap.set("n", "<C-h>", "<Cmd>NvimTreeToggle<CR>")

-- CodeCompanion
vim.keymap.set({ "n", "v" }, "<Leader>a", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
