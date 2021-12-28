au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}
au BufWrite *.rs :Autoformat

"------------------
"     PLUGINS
"------------------
call plug#begin(stdpath('data') . 'nvim/plugged')
  Plug 'morhetz/gruvbox'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'tpope/vim-commentary'
  Plug 'tyru/open-browser.vim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'vim-autoformat/vim-autoformat'
  Plug 'karb94/neoscroll.nvim'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
call plug#end()

" Open Browser config
let g:netrw_nogx = get(g:, 'netrw_nogx', 1)
nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)

" NvimTree config
let g:nvim_tree_special_files = {}
let g:nvim_tree_disable_window_picker = 1
let g:nvim_tree_show_icons = {
  \ 'git': 0,
  \ 'folders': 1,
  \ 'files': 1,
  \ 'folder_arrows': 1,
  \}

lua << EOF
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

-- NvimTree config
require("nvim-tree").setup({
  open_on_setup = false,
  auto_close = true,
  update_focused_file = {
    enable = true,
  },
  view = {
    auto_resize = true,
  },
})

-- Telescope config
local actions = require("telescope.actions")

require("telescope").setup({
defaults = {
  prompt_prefix = "   ",
  selection_caret = "  ",
  entry_prefix = "  ",
  initial_mode = "insert",
  mappings = {
    i = {
      ["<esc>"] = actions.close,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
    },
    n = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
    },
  },
  sorting_strategy = "ascending",
  layout_strategy = "vertical",
  file_ignore_patterns = {
    "node_modules",
    "plugged",
    "target",
  },
},
pickers = {
  find_files = {
    layout_strategy = "center",
    previewer = false,
  },
},
})

------------------
--   MAPPINGS
------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

map("", "<leader>y", '"+y') -- Copy to clipboard in normal, visual, select and operator modes
map("n", "<leader>w", "<cmd>noh<CR>") -- Clear highlights
map("n", "<leader><leader>", "<C-^>")
map("n", "<leader>c", ":edit ~/.config/nvim/init.lua<cr>") -- Edit config file
map("n", "<leader>v", ":source ~/.config/nvim/init.lua<cr>") -- Source config file
map("n", "]<Space>", "o<esc>k") -- Insert blank line underneath cursor
map("n", "<cr>", "o<esc>") -- Insert blank line
map("n", "<bs>", "ddk") -- Remove blank line

-- Ignore case on save/close commands
map("n", ":W", ":w")
map("n", ":Q", ":q")
map("n", ":X", ":x")

map("n", "<c-p>", ":Telescope find_files<CR>")
map("n", "<c-f>", ":Telescope live_grep<CR>")
map("n", "<c-h>", ":NvimTreeToggle<CR>")
EOF

colorscheme gruvbox

