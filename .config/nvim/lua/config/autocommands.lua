-- Open help window in a vertical split
vim.cmd([[autocmd FileType help wincmd L]])

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- For my fat fingers
vim.cmd([[cab W write]])

vim.cmd([[cab, Q, "quit"]])

-- Zen
vim.cmd([[cab, Z, "Zenmode"]])
vim.cmd([[cab, z, "Zenmode"]])
