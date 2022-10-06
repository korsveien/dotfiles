-- https://github.com/akinsho/toggleterm.nvim#setup
require('toggleterm').setup{
  open_mapping = [[<c-\>]],
  shell = '/usr/local/bin/fish',
  autochdir = true,
  shading_factor = '2',
  direction = 'vertical',
  size = vim.o.columns * 0.5,
}
