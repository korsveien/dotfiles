-- Create group to assign commands
-- "clear = true" must be set to prevent loading an
-- auto-command repeatedly every time a file is resourced
local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })


-- Auto formatting
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.yaml", "*.yml" },
    desc = "Auto-format YAML files after saving",
    callback = function()
        local fileName = vim.api.nvim_buf_get_name(0)
        vim.cmd(":!yamlfmt " .. fileName)
    end,
    group = autocmd_group,
})


-- File tree
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function ()
        require("nvim-tree.api").tree.open() -- open file tree on startup
        vim.cmd("wincmd l") -- move focus to main window
    end,
    group = autocmd_group,
})
