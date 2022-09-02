require 'project_nvim'.setup {
    patterns = { '.git', 'Makefile', 'init.vim', 'init.lua' },
    exclude_dirs = { '.cargo/*', 'node_modules/*' },
}

vim.api.nvim_set_keymap('n', '<C-m>', ':Telescope projects<cr>', { silent = true })
