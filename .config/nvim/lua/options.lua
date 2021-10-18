-- stylua: ignore start
local opt = vim.opt

opt.completeopt   = {'menuone', 'noinsert', 'noselect'} -- completion options
opt.expandtab     = true                                -- use spaces insted of tabs
opt.hidden        = true                                -- enable background buffers
opt.ignorecase    = true
opt.list          = true                                -- show some invisible characters
opt.number        = true                                -- show line numbers
opt.scrolloff     = 4                                   -- lines of context
opt.shiftround    = true                                -- round indent to a multiple of shiftwidth
opt.shiftwidth    = 4                                   -- size of an indent
opt.sidescrolloff = 8                                   -- columns of context
opt.smartcase     = true                                -- Do not ignore case with capitals
opt.smartindent   = true                                -- Insert indents automatically
opt.splitbelow    = true                                -- Put new windows below current
opt.splitright    = true                                -- Put new windows right of current
opt.tabstop       = 2                                   -- Number of spaces tabs count for
opt.termguicolors = true                                -- True color support
opt.wildmode      = {'list', 'longest'}                 -- Command-line completion mode
opt.wrap          = false                               -- Disable line wrap
opt.signcolumn    = 'yes'
opt.updatetime    = 250
opt.cursorline    = true
opt.undofile      = true                                -- Persistent undo
vim.cmd [[ set noswapfile ]]
-- stylua: ignore end
