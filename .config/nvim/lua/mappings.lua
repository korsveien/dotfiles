local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ' '

map('', '<leader>y', '"+y') -- Copy to clipboard in normal, visual, select and operator modes

map('n', '<leader>w', '<cmd>noh<CR>') -- Clear highlights

map('n', '<C-l>', ':NV<cr>') -- Search notes

map('n', '<leader><leader>', '<C-^>')

map('n', '<leader>c', ':edit ~/.config/nvim/init.lua<cr>') -- Edit config file
map('n', '<leader>v', ':source ~/.config/nvim/init.lua<cr>') -- Source config file

map('n', ']<Space>', 'o<esc>k') -- Insert blank line underneath cursor
map('n', '<cr>', 'o<esc>') -- Insert blank line
map('n', '<bs>', 'ddk') -- Remove blank line

-- Ignore case on save/close commands
map('n', ':W', ':w')
map('n', ':Q', ':q')
map('n', ':X', ':x')

map('n', '<c-p>', ':Telescope find_files<CR>')
map('n', '<c-f>', ':Telescope live_grep<CR>')
map('n', '<c-e>', ':Telescope commands<CR>')
map('n', '<c-b>', ':Telescope buffers<CR>')
map('n', '<leader>fr', ':Telescope registers<CR>')
