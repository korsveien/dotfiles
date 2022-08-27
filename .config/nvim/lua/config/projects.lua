require 'project_nvim'.setup {
    patterns = { '.git', 'Makefile', 'main.tf', 'init.vim', 'init.lua' },
    exclude_dirs = { '.cargo/*', 'node_modules/*' },
}

vim.api.nvim_set_keymap('n', '<c-m>', ':Telescope projects<cr>', { silent = true })
