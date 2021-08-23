local cmd = vim.cmd
local fn  = vim.fn
local opt = vim.opt
local g   = vim.g

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

map('n', '<C-l>', ':NV<cr>')                       -- Search notes
map('n', '<C-h>', ':NvimTreeToggle<cr>')           -- Toggle file sidebar

map('n', '<leader><leader>', '<C-^>')

map('n', '<leader>r', ':make run<cr>')                              -- Source current file
map('n', '<leader>m', ':make')                              -- Source current file

map('n', '<leader>c', ":edit ~/.config/nvim/init.lua<cr>")   -- Edit config file
map('n', '<leader>v', ":source ~/.config/nvim/init.lua<cr>") -- Source config file

map('n', ']<Space>', 'o<esc>k') -- Insert blank line underneath cursor
map('n', '<cr>', 'o<esc>') -- Insert blank line
map('n', '<bs>', 'ddk')    -- Remove blank line

-- Ignore case on save/close commands
map('n', ':W', ':w')
map('n', ':Q', ':q')
map('n', ':X', ':x')

map('n', '<C-f>', '<cmd>Rg<cr>')
map('n', '<C-p>', '<cmd>Files<cr>')

-------------------- PLUGINS -------------------------------

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('nvim-lua/plenary.nvim')

-- Git
Plug('tpope/vim-fugitive')
Plug('tpope/vim-rhubarb')
Plug('lewis6991/gitsigns.nvim')

-- Search
Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
Plug('junegunn/fzf.vim')

-- File tree
Plug('kyazdani42/nvim-web-devicons')
Plug('kyazdani42/nvim-tree.lua')

-- Buffers
Plug('akinsho/nvim-bufferline.lua')

-- LSP
Plug('neovim/nvim-lspconfig')
Plug('kabouzeid/nvim-lspinstall')
Plug('ray-x/lsp_signature.nvim')

-- Autocomplete
Plug('ms-jpq/coq_nvim', {branch = 'coq'})

-- -- Colors,icons and syntax
Plug('nvim-treesitter/nvim-treesitter')
Plug('etdev/vim-hexcolor')
Plug('morhetz/gruvbox')

-- -- Notes
--Plug('alok/notational-fzf-vim')

-- -- Editing
Plug('junegunn/vim-easy-align')
Plug('tpope/vim-commentary')
Plug('terryma/vim-multiple-cursors')
Plug('vim-autoformat/vim-autoformat')
Plug('jiangmiao/auto-pairs')

vim.call('plug#end')

require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
    }
}

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

-- File explorer
local present, tree_c = pcall(require, "nvim-tree.config")
if not present then
    return
end

local tree_cb = tree_c.nvim_tree_callback

g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
g.nvim_tree_gitignore = 1
g.nvim_tree_auto_open = 0
g.nvim_tree_auto_close = 0 -- closes tree when it's the last window
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 1
g.nvim_tree_git_hl = 1
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_root_folder_modifier = table.concat({
    ":t:gs?$?/..",
    string.rep(" ", 1000),
    "?:gs?^??",
})
g.nvim_tree_tab_open = 0
g.nvim_tree_allow_resize = 1
g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_update_cwd = 1

g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌",
    },
    folder = {
        -- disable indent_markers option to get arrows working or if you want both arrows and indent then just add the arrow icons in front            ofthe default and opened folders below!
        -- arrow_open = "",
        -- arrow_closed = "",
        default = "",
        open = "",
        empty = "", -- 
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
}

g.nvim_tree_bindings = {
    { key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
    { key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
    { key = "v", cb = tree_cb("vsplit") },
    { key = "x", cb = tree_cb("split") },
    { key = "<C-t>", cb = tree_cb("tabnew") },
    { key = "H", cb = tree_cb("toggle_dotfiles") },
    { key = "R", cb = tree_cb("refresh") },
    { key = "x", cb = tree_cb("cut") },
    { key = "gc", cb = tree_cb("copy") },
    { key = "p", cb = tree_cb("paste") },
    { key = "y", cb = tree_cb("copy_name") },
    { key = "Y", cb = tree_cb("copy_path") },
    { key = "gy", cb = tree_cb("copy_absolute_path") },
    { key = "-", cb = tree_cb("dir_up") },
    { key = "q", cb = tree_cb("close") },
    { key = "?", cb = tree_cb("toggle_help") },
}

-- Autocomplete
g.coq_settings = {
    auto_start = true
}

-- LSP
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
    -- virtual_text = false,
    virtual_text = { prefix = "" },
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
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
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
--vim.cmd('let g:nv_search_paths = ["~/Jottacloud/notes"]')

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

--Save undo history
vim.cmd [[set undofile]]

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

cmd 'colorscheme gruvbox'

-------------------- COMMANDS -------------------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}' -- highlight on yank
cmd 'au BufWrite *.rs :Autoformat'
cmd 'autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo'
