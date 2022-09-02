vim.cmd [[
set clipboard ^="unnamed, unnamedplus"
set noswapfile
]]
vim.opt.expandtab     = true -- use spaces insted of tabs
vim.opt.hidden        = true -- enable background buffers
vim.opt.listchars     = 'trail:-' -- show some invisible characters
vim.opt.number        = true -- show line numbers
vim.opt.shiftround    = true -- round indent to a multiple of shiftwidth
vim.opt.shiftwidth    = 4 -- size of an indent
vim.opt.sidescrolloff = 8 -- columns of context
vim.opt.smartcase     = true -- do not ignore case with capitals
vim.opt.smartindent   = true -- insert indents automatically
vim.opt.splitright    = true -- put new windows right of current
vim.opt.tabstop       = 2 -- number of spaces tabs count for
vim.opt.termguicolors = true -- true color support
vim.wo.wrap           = false -- disable line wrap
vim.opt.undofile      = true -- persistent undo
vim.opt.hidden        = true
vim.opt.ignorecase    = true
vim.opt.signcolumn    = 'yes'
vim.opt.updatetime    = 250
vim.opt.cursorline    = true
vim.opt.completeopt   = 'menuone,noinsert,noselect'
vim.opt.wildmode      = 'list,longest'
vim.opt.shell         = '/bin/bash' -- NvimTree slows down when using fish
vim.opt.fcs           = 'eob: '
vim.opt.textwidth     = 144
