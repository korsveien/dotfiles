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
map('n', '<leader>c', ":edit ~/.config/nvim/init.lua<cr>")   -- Edit config file
map('n', '<leader>v', ":source ~/.config/nvim/init.lua<cr>") -- Source config file

map('n', ']<Space>', 'o<esc>k') -- Insert blank line underneath cursor
map('n', '<cr>', 'o<esc>') -- Insert blank line
map('n', '<bs>', 'ddk')    -- Remove blank line

-- Ignore case on save/close commands
map('n', ':W', ':w')
map('n', ':Q', ':q')
map('n', ':X', ':x')

-------------------- PLUGINS -------------------------------
-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- Git
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

    -- -- Files, search and tags
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
    use 'ludovicchabant/vim-gutentags'
    use 'scrooloose/nerdtree'

    -- -- Syntax, LSP and autocomplete
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-compe'
    use 'L3MON4D3/LuaSnip'

    -- -- Colors,icons and syntax
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'
    use 'etdev/vim-hexcolor'
    use 'morhetz/gruvbox'

    use 'alok/notational-fzf-vim'

    -- -- Editing
    use 'junegunn/vim-easy-align'
    use 'tpope/vim-commentary'
    use 'terryma/vim-multiple-cursors'
end)

require('compe').setup {
  source = {
    path = true,
    nvim_lsp = true,
    luasnip = true,
    buffer = false,
    calc = false,
    nvim_lua = false,
    vsnip = false,
    ultisnips = false,
  },
}

require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
  }
}

-- LSP
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable the following language servers
local servers = { 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
      },
    },
  },
}

-- Notes
cmd('let g:nv_search_paths = ["~/Jottacloud/notes"]')

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

--Save undo history
vim.cmd [[set undofile]]

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

cmd 'colorscheme gruvbox'

-------------------- COMMANDS -------------------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}' -- highlight on yank

