au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}
au BufWrite *.rs,*.go :Autoformat
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()

"------------------
"     PLUGINS
"------------------
call plug#begin(stdpath('data') . '/plugged')
  Plug 'https://github.com/hashivim/vim-terraform'
  Plug 'sainnhe/gruvbox-material'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'vim-test/vim-test'
  Plug 'tyru/open-browser.vim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'vim-autoformat/vim-autoformat'
  Plug 'karb94/neoscroll.nvim'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
  Plug 'rust-lang/rust.vim'
  Plug 'khaveesh/vim-fish-syntax'
  Plug 'neovim/nvim-lspconfig'
call plug#end()


"------------------
"   SETTINGS
"------------------
set expandtab                " use spaces insted of tabs
set hidden                   " enable background buffers
set list                     " show some invisible characters
set number                   " show line numbers
set shiftround               " round indent to a multiple of shiftwidth
set shiftwidth=4             " size of an indent
set sidescrolloff=8          " columns of context
set smartcase                " Do not ignore case with capitals
set smartindent              " Insert indents automatically
set splitbelow               " Put new windows below current
set splitright               " Put new windows right of current
set tabstop=2                " Number of spaces tabs count for
set termguicolors            " True color support
set nowrap                   " Disable line wrap
set undofile                 " Persistent undo
set hidden
set ignorecase
set signcolumn=yes
set updatetime=250
set cursorline
set noswapfile
set completeopt="menuone,noinsert,noselect"
set wildmode="list,longest" 
set clipboard^=unnamed,unnamedplus

set shell=/bin/bash


"------------------
"   MAPPINGS
"------------------
let mapleader = " "



nnoremap <leader><leader> <c-^>                              " Jump to previous buffer
nnoremap <leader>w <cmd>noh<cr>                              " Clear search highlights
nnoremap <leader>c :edit ~/.config/nvim/init.vim<cr>         " Edit config file
nnoremap <leader>v :source ~/.config/nvim/init.vim<cr>       " Source config file
nnoremap ]<Space> o<esc>                                     " Insert blank line underneath cursor

" Ignore case on save/close commands
nnoremap :W :w
nnoremap :Q :q
nnoremap :X :x

" If i want to quit, I want to quit
nnoremap :q :q!

nnoremap <c-p> :Telescope find_files<cr>
nnoremap <c-f> :Telescope live_grep<cr>
nnoremap <c-e> :Telescope buffers<cr>
nnoremap <c-t> :Telescope lsp_document_symbols<cr>
nnoremap <c-l> :Telescope lsp_code_actions<cr>
nnoremap <c-h> :NvimTreeToggle<cr>

" Copy to systen clipboard on mac
vmap '' :w !pbcopy<CR><CR>

"------------------
"   PLUGIN CONFIG
"------------------

" autoformat
let g:formatdef_tf_format = '"terraform fmt -"'
let g:formatters_tf = ['tf_format']

nmap <silent> <leader<r> :make run<CR>

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>l :TestLast<CR>

let test#strategy = 'neovim'
"let test#neovim#term_position = "vert"
let test#neovim#start_normal = 1


let g:rust_doc#downloaded_rust_doc_dir = '~/Documents/rust-docs'

" Open Browser config
let g:netrw_nogx = get(g:, 'netrw_nogx', 1)
nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)

" COQ
nnoremap <leader><a> :COQnow [--shut-up]<CR>


lua << EOF
vim.g.coq_settings = {
    keymap = {
        jump_to_mark = "<c-,>"
    }
}

require('gitsigns').setup()

-- LSP config
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'rust_analyzer', 'terraformls' }

local coq = require "coq"
local lspconfig = require "lspconfig"


for _, server in pairs(servers) do

  lspconfig[server].setup {
      coq.lsp_ensure_capabilities {
        on_attach = on_attach,
        flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
        }
    }
  }

end

-- NvimTree config
require("nvim-tree").setup({
  open_on_setup = false,
  update_focused_file = {
    enable = true,
  },
  view = {
    auto_resize = true,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 300,
  }
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
    ".git",
  },
},
pickers = {
  find_files = {
    layout_strategy = "center",
    previewer = false,
    hidden = true,
  },
  marks = {
    layout_strategy = "center",
    previewer = false,
    hidden = true,
  },
  buffers = {
    layout_strategy = "center",
    previewer = false,
    hidden = true,
  },
  lsp_document_symbols = {
    layout_strategy = "center",
    previewer = false,
    hidden = true,
  },
},
})
EOF

colorscheme gruvbox-material
