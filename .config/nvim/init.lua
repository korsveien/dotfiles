local cmd = vim.cmd
local fn  = vim.fn
local opt = vim.opt
local g   = vim.g

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-------------------- PLUGINS -------------------------------

cmd [[packadd packer.nvim]]

require('packer').startup(function(use)

use 'wbthomason/packer.nvim'

use 'nvim-lua/plenary.nvim'
use 'nvim-lua/popup.nvim'

-- Git
use 'tpope/vim-fugitive'
use 'tpope/vim-rhubarb'
use 'lewis6991/gitsigns.nvim'
use 'sindrets/diffview.nvim'

-- Search
use 'nvim-telescope/telescope.nvim'

-- File tree
use 'preservim/nerdtree'

-- Icons
use 'ryanoasis/vim-devicons'
use 'kyazdani42/nvim-web-devicons'

-- Buffers
use 'akinsho/nvim-bufferline.lua'

-- LSP
use 'neovim/nvim-lspconfig'
use 'kabouzeid/nvim-lspinstall'
use 'ray-x/lsp_signature.nvim'


-- Autocomplete
use {'ms-jpq/coq_nvim', branch = 'coq'}

-- Treesitter
use { 'nvim-treesitter/nvim-treesitter', branch = '0.5-compat', run = ':TSUpdate' }
use 'nvim-treesitter/nvim-treesitter-textobjects'

-- Colorschemes
use 'sheerun/vim-polyglot'
use 'morhetz/gruvbox'
use 'Mofiqul/vscode.nvim'
use 'ap/vim-css-color'

-- Syntax
use 'mboughaba/i3config.vim'

-- -- Notes
use 'alok/notational-fzf-vim'

-- -- Editing
use 'junegunn/vim-easy-align'
use 'tpope/vim-commentary'
use 'terryma/vim-multiple-cursors'
use 'vim-autoformat/vim-autoformat'
use 'jiangmiao/auto-pairs'


end)

-------------------- MAPPINGS -------------------------------
vim.g.mapleader = ' '

map('', '<leader>y', '"+y')       -- Copy to clipboard in normal, visual, select and operator modes

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<leader>w', '<cmd>noh<CR>') -- Clear highlights

map('n', '<C-l>', ':NV<cr>')                       -- Search notes
map('n', '<C-h>', ':NERDTreeToggle<cr>')           -- Toggle file sidebar

map('n', '<leader><leader>', '<C-^>')

map('n', '<leader>c', ":edit ~/.config/nvim/init.lua<cr>")   -- Edit config file
map('n', '<leader>v', ":source ~/.config/nvim/init.lua<cr>") -- Source config file

map('n', ']<Space>', 'o<esc>k') -- Insert blank line underneath cursor
map('n', '<cr>', 'o<esc>') -- Insert blank line
map('n', '<bs>', 'ddk')    -- Remove blank line

-- Ignore case on save/close commands
map('n', ':W', ':w')
map('n', ':Q', ':q')
map('n', ':X', ':x')

require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
    }
}

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-j"] = actions.move_selection_next,
        ["<c-k"] = actions.move_selection_previous,
      },
      n = {
        ["<c-j"] = actions.move_selection_next,
        ["<c-k"] = actions.move_selection_previous,
      }
    },
  }
}

map('n', '<c-p>', ':Telescope find_files<CR>')
map('n', '<c-e>', ':Telescope buffers<CR>')
map('n', '<c-f>', ':Telescope live_grep<CR>')
map('n', '<leader>r', ':Telescope registers<CR>')
map('n', '<leader>a', ':Telescope lsp_code_actions<CR>')


-- Bufferline
require("bufferline").setup({
    options = {
        show_close_icon = true,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diagnostics_dict)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and " "
                or (e == "warning" and " " or "")
                s = s .. sym .. n
            end
            return s
        end,
    },
})

-- Autocomplete
g.coq_settings = {
    auto_start = 'shut-up'
}

-- LSP
cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

local nvim_lsp = require 'lspconfig'
local coq      = require 'coq'

require'lspinstall'.setup() -- important
require("lsp_signature").setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
    require'lspconfig'[server].setup(coq.lsp_ensure_capabilities{})
end

vim.fn.sign_define(
"LspDiagnosticsSignError",
{ text = "", numhl = "LspDiagnosticsDefaultError" }
)
vim.fn.sign_define(
"LspDiagnosticsSignWarning",
{ text = "", numhl = "LspDiagnosticsDefaultWarning" }
)
vim.fn.sign_define(
"LspDiagnosticsSignInformation",
{ text = "", numhl = "LspDiagnosticsDefaultInformation" }
)
vim.fn.sign_define(
"LspDiagnosticsSignHint",
{ text = "", numhl = "LspDiagnosticsDefaultHint" }
)

-- set default prefix.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics,
{
    virtual_text = false,
    signs = true,
    update_in_insert = false,
}
)

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)",
}

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
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

-- Notes
g.nv_search_paths = { '~/Jottacloud/notes' }

-------------------- OPTIONS -------------------------------
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
opt.signcolumn = 'yes'
opt.updatetime = 250

--Save undo history
cmd [[ set undofile ]]

--Set color scheme
g.vscode_style = "dark"
cmd [[ colorscheme vscode ]]
--cmd 'colorscheme gruvbox'

-------------------- AUTOCOMMANDS -------------------------------
cmd [[au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}]] -- highlight on yank
cmd [[au BufWrite *.rs,*.swift :Autoformat]]
cmd [[autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo]]
-- Global mark I for last edit
cmd [[autocmd InsertLeave * execute 'normal! mI']]

-- Syntax highlight sway config
cmd [[aug i3config_ft_detection
        au!
        au BufNewFile,BufRead ~/.config/sway/config set filetype=i3config
    aug end
]]
