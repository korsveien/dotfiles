autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}
autocmd BufWritePre *.tf,*.go,*.vim,*.lua lua vim.lsp.buf.formatting()
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWinEnter * if &filetype == 'help' | wincmd L | endif

set clipboard& clipboard^=unnamed,unnamedplus
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif"

"------------------
"     PLUGINS
"------------------
call plug#begin(stdpath('data') . '/plugged')

    Plug 'https://github.com/pederpus/gruvbox-material'
    Plug 'https://github.com/vim-test/vim-test'
    Plug 'https://github.com/tyru/open-browser.vim'
    Plug 'https://github.com/lewis6991/gitsigns.nvim'
    Plug 'https://github.com/terryma/vim-multiple-cursors'
    Plug 'https://github.com/karb94/neoscroll.nvim'
    Plug 'https://github.com/jiangmiao/auto-pairs'
    Plug 'https://github.com/akinsho/toggleterm.nvim', {'tag' : 'v1.*'}
    Plug 'https://github.com/ojroques/vim-oscyank'

    " Utility libraries
    Plug 'https://github.com/nvim-lua/popup.nvim'
    Plug 'https://github.com/nvim-lua/plenary.nvim'

    " File explorer
    Plug 'https://github.com/kyazdani42/nvim-tree.lua'
    Plug 'https://github.com/kyazdani42/nvim-web-devicons'
    Plug 'https://github.com/ahmedkhalf/project.nvim'

    " Tim Pope essentials
    Plug 'https://github.com/tpope/vim-commentary'
    Plug 'https://github.com/tpope/vim-fugitive'
    Plug 'https://github.com/tpope/vim-rhubarb'
    Plug 'https://github.com/tpope/vim-unimpaired'
    Plug 'https://github.com/tpope/vim-surround'

    " Telescope
    Plug 'https://github.com/nvim-telescope/telescope.nvim'
    Plug 'https://github.com/nvim-telescope/telescope-symbols.nvim'
    Plug 'https://github.com/nvim-telescope/telescope-github.nvim'

    " LSP and autocompletion
    Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'https://github.com/neovim/nvim-lspconfig'
    Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
    Plug 'https://github.com/hrsh7th/cmp-buffer'
    Plug 'https://github.com/hrsh7th/cmp-path'
    Plug 'https://github.com/hrsh7th/cmp-cmdline'
    Plug 'https://github.com/hrsh7th/nvim-cmp'
    Plug 'https://github.com/hrsh7th/vim-vsnip'
    Plug 'https://github.com/rafamadriz/friendly-snippets'

    " Language support
    Plug 'https://github.com/google/vim-jsonnet'
    Plug 'https://github.com/hashivim/vim-terraform'
    Plug 'https://github.com/rust-lang/rust.vim'
    Plug 'https://github.com/khaveesh/vim-fish-syntax'

call plug#end()

"------------------
"   MAPPINGS
"------------------
let mapleader = " "
nnoremap <leader><leader> <c-^>                              " Jump to previous buffer
nnoremap <leader>c :vsplit ~/.config/nvim/init.vim<cr>       " Edit config file

" Ignore case on save/close commands
nnoremap :W :w
nnoremap :Q :q
nnoremap :X :x

" If i want to quit, I want to quit
nnoremap :q :q!

nnoremap <c-p> :Telescope find_files<cr>
nnoremap <c-g> :Telescope live_grep<cr>
nnoremap <c-e> :Telescope buffers<cr>
nnoremap <c-t> :Telescope lsp_document_symbols<cr>
nnoremap <c-h> :NvimTreeToggle<cr>

"------------------
"   PLUGIN CONFIG
"------------------

" fugitive/rhubarb
nnoremap <leader>o :GBrowse<CR>
nnoremap <leader>b :Git blame<CR>

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
require'config/gitsigns'
require'config/lsp'
require'config/nvimtree'
require'config/options'
require'config/statusline'
require'config/telescope'
require'config/treesitter'
require'config/colors'
require'config/terminal'
require'config/projects'
EOF
