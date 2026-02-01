-------------
-- PRELUDE --
-------------

-- Based on: https://github.com/radleylewis/nvim-lite

-- Set leader before any plugins are loaded
vim.g.mapleader          = " "
vim.g.maplocalleader     = " "

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-------------
-- PLUGINS --
-------------
vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",         -- Collection of LSP configurations
    "https://github.com/rebelot/kanagawa.nvim",         -- Color scheme
    "https://github.com/nvim-tree/nvim-tree.lua",       -- File tree
    "https://github.com/nvim-tree/nvim-web-devicons",   -- Optional dependency of nvim-tree
    "https://github.com/mg979/vim-visual-multi",        -- Multiple cursors
    "https://github.com/nvim-telescope/telescope.nvim", -- Picker
    "https://github.com/nvim-lua/plenary.nvim",         -- Dependeny of Telescope
    "https://github.com/lewis6991/gitsigns.nvim",       -- Git markers in signcolumn
})

-- Modularize based on feature
require('filetree')
require('picker')
require('vcs')
require('statusline')

--------------
--   LSP    --
--------------
vim.lsp.enable({
    "gdscript",
    "lua_ls",
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            }
        }
    }
})

--------------
-- VIM OPTS --
--------------

-- Basic settings
vim.opt.number        = true  -- Show line numbers
vim.opt.wrap          = false -- Do not wrap lines
vim.opt.scrolloff     = 10    -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8     -- Keep 8 columns left/right of the cursor

-- Indentation
vim.opt.shiftwidth    = 2    -- Indent width
vim.opt.tabstop       = 2    -- Tab width
vim.opt.softtabstop   = 2    -- Soft tab stop
vim.opt.smartindent   = true -- Smart auto-indenting
vim.opt.expandtab     = true -- Use spaces instesd of tabs
vim.opt.autoindent    = true -- Copy indent from current line

-- Search settings
vim.opt.ignorecase    = true  -- Case insensitive search
vim.opt.smartcase     = true  -- Case sensitive if uppercase in search
vim.opt.hlsearch      = false -- Don't highlight search results
vim.opt.incsearch     = true  -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true  --- Enable 24-bit colors
vim.opt.signcolumn    = "yes" -- Always show the signcolumn
vim.opt.showmatch     = true  -- Highlight matching brackets
vim.opt.matchtime     = 2     -- How long to show matching bracket
vim.opt.cmdheight     = 1     -- Command line height
vim.opt.showmode      = false -- Don't show mode in command line
vim.opt.pumheight     = 10    -- Popup menu height
vim.opt.pumblend      = 10    -- Popup menu transparency
vim.opt.winblend      = 0     -- Floating window transparency
vim.opt.conceallevel  = 0     -- Don't hide markup
vim.opt.concealcursor = ""    -- Don't hide cursor line markup
vim.opt.lazyredraw    = true  -- Don't redraw during macros
vim.opt.synmaxcol     = 300   -- Syntax highlighting limit

-- File handling
vim.opt.backup        = false                           -- Don't create backup files
vim.opt.writebackup   = false                           -- Don't create backup before writing
vim.opt.swapfile      = false                           -- Don't create swap files
vim.opt.undofile      = true                            -- Persistent undo
vim.opt.undodir       = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.opt.updatetime    = 300                             -- Faster completion
vim.opt.timeoutlen    = 500                             -- Key timeout duration
vim.opt.ttimeoutlen   = 0                               -- Key code timeout
vim.opt.autoread      = true                            -- Auto reload files changed outside vim
vim.opt.autowrite     = false                           -- Don't auto save

-- Behaviour settings
vim.opt.hidden        = true               -- Allow hidden buffers
vim.opt.errorbells    = false              -- No error bells
vim.opt.backspace     = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir     = false              -- Don't auto change directory
vim.opt.selection     = "exclusive"        -- Selection behavior
vim.opt.mouse         = "a"                -- Enable mouse support
vim.opt.encoding      = "UTF-8"            -- Set encoding
vim.opt.modifiable    = true               -- Allow buffer modifications
vim.opt.clipboard:append("unnamedplus")    -- Use system clipboard
vim.opt.iskeyword:append("-")              -- Treat dash as part of word
vim.opt.path:append("**")                  -- include subdirectories in search

-- Split behavior
vim.opt.splitbelow   = true -- Horizontal splits go below
vim.opt.splitright   = true -- Vertical splits go right

-- Autocomplete
vim.opt.complete     = ".,o"                          -- Use buffer and omnifunc
vim.opt.completeopt  = "fuzzy,menuone,noselect,popup" -- Completion options
vim.opt.autocomplete = true                           -- Turn on native autocomplete
vim.opt.pumheight    = 7                              -- Height of popup menu

vim.keymap.set('i', '<Tab>', function()
    return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
end, { expr = true })

vim.keymap.set('i', '<S-Tab>', function()
    return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
end, { expr = true })

-- Command line autocomplete
vim.cmd [[
  autocmd CmdlineChanged [:\/\?] call wildtrigger()
  set wildmode=noselect:lastused,full
  set wildoptions=pum
]]

-----------------
--  KEYMAPS    --
-----------------
-- Convenvience
vim.keymap.set("n", "<C-q>", "<Cmd>quit!<CR>")
vim.keymap.set("n", "<leader>j", "<Cmd>set ft=json<CR>")            -- Set filetype to json
vim.keymap.set("n", "<leader>s", "<Cmd>source %<CR>")               -- Source the current file
vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim/init.lua<CR>") -- Open the nvim config file

-- Move lines up/down
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Clear search highlights
vim.keymap.set("n", "<C-l>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-------------------
--  AUTOCOMMANDS --
-------------------
-- Open help window in a vertical split
vim.cmd([[autocmd FileType help wincmd L]])

-- Format on save
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

-- Highlight selection on yank
vim.cmd [[ autocmd TextYankPost <buffer> lua vim.highlight.on_yank() ]]

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Open file to last edit location
vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = { '*' },
    desc = 'When editing a file, always jump to the last known cursor position',
    callback = function()
        local line = vim.fn.line '\'"'
        if
            line >= 1
            and line <= vim.fn.line '$'
            and vim.bo.filetype ~= 'commit'
            and vim.fn.index({ 'xxd', 'gitrebase' }, vim.bo.filetype) == -1
        then
            vim.cmd 'normal! g`"'
        end
    end,
})

-------------------
--   COLORS      --
-------------------

-- きれいね
vim.cmd("colorscheme kanagawa-dragon")
