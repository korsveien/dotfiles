-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- MAPPINGS -------------------------------
vim.g.mapleader = ' '

map('', '<leader>y', '"+y')       -- Copy to clipboard in normal, visual, select and operator modes
map('i', '<C-u>', '<C-j>u<C-u>')  -- Make <C-u> undo-friendly
map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly

map('', '<C-s>', ':sus<cr>') -- Suspend to terminal

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<leader>w', '<cmd>noh<CR>') -- Clear highlights

map('n', '<C-p>', '<cmd>Telescope find_files<cr>') -- Search for file
map('n', '<C-f>', '<cmd>Telescope live_grep<cr>')  -- Search text in files
map('n', '<C-b>', '<cmd>Telescope buffers<cr>')    -- Search for buffer
map('n', '<C-t>', '<cmd>Telescope help_tags<cr>')  -- Search in help
map('n', '<C-l>', ':NV<cr>')                       -- Search notes
map('n', '<C-h>', ':NERDTreeToggle<cr>')           -- Toggle file sidebar

map('n', '<leader><leader>', 'C-^')

map('n', '<leader>r', ':source %<cr>')                              -- Source current file
map('n', '<leader>c', ":edit $XDG_CONFIG_HOME/nvim/init.lua<cr>")   -- Edit config file
map('n', '<leader>v', ":source $XDG_CONFIG_HOME/nvim/init.lua<cr>") -- Source config file

map('n', ']<Space>', 'o<esc>k') -- Insert blank line underneath cursor
map('n', '<cr>', 'o<esc>') -- Insert blank line
map('n', '<bs>', 'ddk')    -- Remove blank line

-- Ignore case on save/close commands
map('n', ':W', ':w')
map('n', ':Q', ':q')
map('n', ':X', ':x')

-------------------- PLUGINS -------------------------------
cmd 'packadd paq-nvim'               -- load the package manager
local paq = require('paq-nvim').paq  -- a convenient alias
paq {'savq/paq-nvim', opt = true}    -- paq-nvim manages itself

-- Fuzzy Search
paq {'junegunn/fzf', run = fn['fzf#install']}
paq 'junegunn/fzf.vim'
paq 'nvim-lua/popup.nvim'
paq 'nvim-lua/plenary.nvim'
paq 'nvim-telescope/telescope.nvim'

-- Files
paq 'scrooloose/nerdtree'

-- Autocompletion
paq 'hrsh7th/nvim-compe'

-- Tree-sitter
paq 'nvim-treesitter/nvim-treesitter'
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-- LSP
paq 'neovim/nvim-lspconfig'

-- Colors and icons
paq 'kyazdani42/nvim-web-devicons'
paq 'etdev/vim-hexcolor'
paq 'chriskempson/base16-vim'
cmd 'colorscheme base16-tomorrow-night'

-- Notes
paq 'alok/notational-fzf-vim'
cmd('let g:nv_search_paths = ["~/Jottacloud/notes"]')

-- Formatting
paq 'junegunn/vim-easy-align'

-- Editing
paq 'terryma/vim-multiple-cursors'

-------------------- OPTIONS -------------------------------
opt.completeopt   = {'menuone', 'noinsert', 'noselect'} -- completion options (for nvim-compe)
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

-------------------- COMMANDS -------------------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}' -- highlight on yank

