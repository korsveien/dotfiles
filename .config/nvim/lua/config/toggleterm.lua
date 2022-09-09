require('toggleterm').setup{
  open_mapping = [[<c-\>]],
  autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
  shading_factor = '2', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  direction = 'vertical',
  size = vim.o.columns * 0.4,
  shell = '/usr/local/bin/fish',
}
