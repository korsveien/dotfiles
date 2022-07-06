vim.cmd [[ colorscheme gruvbox-material ]]

-- FIXME: must be after colorscheme
local background = '#252525'
local foreground = '#ecdbb2'

local black = '#353535'
local blue = '#549699'
local blue_bright = '#94b3a8'
local cyan = '#79aa7d'
local green = '#a8a521'
local magenta = '#bf7897'
local red = '#d73925'
local white = '#b7a996'
local yellow = '#dfa82a'

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
vim.api.nvim_set_hl(0, 'NvimTreeGitDirty', { fg = red, bg = background })

vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = black, bg = white })
vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = black, bg = white })

vim.api.nvim_set_hl(0, 'Search', { fg = black, bg = yellow })
vim.api.nvim_set_hl(0, 'Visual', { fg = black, bg = blue_bright })
