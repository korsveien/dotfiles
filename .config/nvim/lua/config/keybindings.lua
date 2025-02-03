-- Convenvience
vim.keymap.set("n", "<C-q>", ":quit!<CR>")
vim.keymap.set("n", "<C-s>", ":source $MYVIMRC<CR>")

-- For fat fingers
vim.keymap.set("n", ":W", ":w")
vim.keymap.set("n", ":Q", ":q")

-- File picker
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>")

-- File Tree
vim.keymap.set("n", "<C-h>", "<Cmd>Neotree toggle<CR>")
