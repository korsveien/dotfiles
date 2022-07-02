autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}
autocmd BufWritePre *.tf,*.go,*.vim,*.lua lua vim.lsp.buf.formatting()
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWinEnter * if &filetype == 'help' | wincmd L | endif

"------------------
"     PLUGINS
"------------------
call plug#begin(stdpath('data') . '/plugged')
    Plug 'https://github.com/pederpus/gruvbox-material'
    Plug 'https://github.com/kyazdani42/nvim-tree.lua'
    Plug 'https://github.com/kyazdani42/nvim-web-devicons'
    Plug 'https://github.com/tpope/vim-commentary'
    Plug 'https://github.com/tpope/vim-fugitive'
    Plug 'https://github.com/tpope/vim-rhubarb'
    Plug 'https://github.com/vim-test/vim-test'
    Plug 'https://github.com/tyru/open-browser.vim'
    Plug 'https://github.com/nvim-telescope/telescope.nvim'
    Plug 'https://github.com/lewis6991/gitsigns.nvim'
    Plug 'https://github.com/terryma/vim-multiple-cursors'
    Plug 'https://github.com/karb94/neoscroll.nvim'

    " Utility libraries
    Plug 'https://github.com/nvim-lua/popup.nvim'
    Plug 'https://github.com/nvim-lua/plenary.nvim'

    " LSP and autocompletion
    Plug 'https://github.com/neovim/nvim-lspconfig'
    Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
    Plug 'https://github.com/hrsh7th/cmp-buffer'
    Plug 'https://github.com/hrsh7th/cmp-path'
    Plug 'https://github.com/hrsh7th/cmp-cmdline'
    Plug 'https://github.com/hrsh7th/nvim-cmp'
    Plug 'https://github.com/hrsh7th/vim-vsnip'

    " Language support
    Plug 'https://github.com/google/vim-jsonnet'
    Plug 'https://github.com/jiangmiao/auto-pairs'
    Plug 'https://github.com/hashivim/vim-terraform'
    Plug 'https://github.com/rust-lang/rust.vim'
    Plug 'https://github.com/khaveesh/vim-fish-syntax'
call plug#end()


"------------------
"   SETTINGS
"------------------
set expandtab                " use spaces insted of tabs
set hidden                   " enable background buffers
set listchars=trail:-        " show some invisible characters
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
nnoremap <leader>c :vsplit ~/.config/nvim/init.vim<cr>       " Edit config file
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
nnoremap <c-h> :NvimTreeToggle<cr>
nnoremap <c-l> :NvimTreeResize 50<cr>

"------------------
"   PLUGIN CONFIG
"------------------

" fugitive/rhubarb
nnoremap <c-g> :GBrowse<CR>
nnoremap <c-b> :Git blame<CR>

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

lua <<EOF
require'statusline'
require'plugins'
require'lsp'
EOF

colorscheme gruvbox-material

lua <<EOF
local background = '#252525'
local foreground = '#ecdbb2'

local black = '#353535'
local blue = '#549699'
local red = '#d73925'
local green = '#a8a521'
local yellow = '#dfa82a'
local magenta = '#bf7897'
local cyan = '#79aa7d'
local white = '#b7a996'

vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { fg = blue, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = blue, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFileName', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeFileIcon', { fg = foreground, bg = background })
vim.api.nvim_set_hl(0, 'NvimTreeCursorLine', { fg = foreground, bg = white })

vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = foreground, bg = white })
vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = foreground, bg = white })
-- vim.api.nvim_set_hl(0, 'TelescopeResultsFileIcon', { fg = foreground, bg = white })
EOF
