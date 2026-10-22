local splits = require('smart-splits')

splits.setup({
    mux = { backend = vim.env.TMUX and 'smart-splits-backend-tmux' or {} },
})

-- Alt+hjkl moves between Neovim splits and continues into tmux panes at the edge
vim.keymap.set('n', '<M-h>', splits.move_cursor_left, { desc = 'Move to left split/pane' })
vim.keymap.set('n', '<M-j>', splits.move_cursor_down, { desc = 'Move to split/pane below' })
vim.keymap.set('n', '<M-k>', splits.move_cursor_up, { desc = 'Move to split/pane above' })
vim.keymap.set('n', '<M-l>', splits.move_cursor_right, { desc = 'Move to right split/pane' })

-- Alt+Shift+HJKL resizes the current split/pane
vim.keymap.set('n', '<M-H>', splits.resize_left, { desc = 'Resize split/pane left' })
vim.keymap.set('n', '<M-J>', splits.resize_down, { desc = 'Resize split/pane down' })
vim.keymap.set('n', '<M-K>', splits.resize_up, { desc = 'Resize split/pane up' })
vim.keymap.set('n', '<M-L>', splits.resize_right, { desc = 'Resize split/pane right' })
