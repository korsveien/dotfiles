-- https://github.com/morhetz/gruvbox
-- /Users/peder/.local/share/nvim/plugged/gruvbox-material/autoload/gruvbox-material.vim

vim.cmd [[ 
if has('termguicolors')
  set termguicolors
endif

let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_foreground = 'material'

"/path/to/gruvbox-material/autoload/gruvbox_material.vim
"let g:gruvbox_material_colors_override = {
"\ 'bg0': ['#1d2021', '234'], 
"\ 'bg2': ['#282828', '235']
"}

colorscheme gruvbox-material
]]

-- FIXME: must be after colorscheme
local background = '#252525'
local foreground = '#ecdbb2'

local black = '#353535'
local blue = '#549699'
local green = '#a8a521'
local white = '#b7a996'
local yellow = '#d79921'

vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { fg = blue, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = blue, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeEmptyFolderName', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFileName', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFileIcon', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', { fg = black, bg = white })

vim.api.nvim_set_hl(0, 'NvimTreeGitNew', { fg = yellow, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeGitStaged', { fg = green, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeGitDirty', { fg = blue, bg = background })

vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = black, bg = white })
vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = black, bg = white })

vim.api.nvim_set_hl(0, 'Search', { fg = black, bg = yellow })
vim.api.nvim_set_hl(0, 'Visual', { fg = black, bg = blue })
