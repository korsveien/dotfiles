local background = '#252525'
local foreground = '#ecdbb2'

local black = '#353535'
local blue = '#549699'
local red = '#d73925'
local green = '#a8a521'
local yellow = '#dfa82a'
local magenta = '#bf7897'
local cyan = '#79aa7d'
local white = '#b7a996'

vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { fg = blue, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = blue, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFileName', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFileIcon', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', { fg = foreground, bg = white })

vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = foreground, bg = white })
vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = foreground, bg = white })

