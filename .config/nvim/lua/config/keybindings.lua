-- Convenvience
vim.keymap.set("n", "<C-q>", ":quit!<CR>")

-- For fat fingers
vim.keymap.set("n", ":W", ":w")
vim.keymap.set("n", ":Q", ":q")

-- File picker
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>")

-- File Tree
vim.keymap.set("n", "<C-h>", "<Cmd>Neotree toggle<CR>")

-- CodeCompanion
vim.keymap.set({ "n", "v" }, "<Leader>a", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
