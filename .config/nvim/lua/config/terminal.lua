require 'toggleterm'.setup {
    size = vim.api.nvim_win_get_width(0) * 0.4,
    shell = 'fish',
    open_mapping = '<c-l>',
    direction = 'vertical',
    on_open = function(term)
        term.cmd = 'cd ' .. vim.fn.getcwd()
    end,
}
