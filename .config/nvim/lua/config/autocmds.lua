-- Create group to assign commands
-- "clear = true" must be set to prevent loading an
-- auto-command repeatedly every time a file is resourced
local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })


-- Open file tree on startup
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     callback = function ()
--         require("nvim-tree.api").tree.open() -- open file tree on startup
--         -- vim.cmd("wincmd l") -- move focus to main window
--     end,
--     group = autocmd_group,
-- })

vim.cmd [[
autocmd BufWinEnter * if &filetype == 'help' | wincmd L | endif
set clipboard& clipboard^=unnamed,unnamedplus
]]
