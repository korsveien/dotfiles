autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWinEnter * if &filetype == 'help' | wincmd L | endif

set clipboard& clipboard^=unnamed,unnamedplus

"------------------
"     PLUGINS
"------------------
call plug#begin(stdpath('data') . '/plugged')


    Plug 'https://github.com/tyru/open-browser.vim'
    Plug 'https://github.com/terryma/vim-multiple-cursors'
    Plug 'https://github.com/karb94/neoscroll.nvim'
    Plug 'https://github.com/lewis6991/gitsigns.nvim'

    " Utility libraries
    Plug 'https://github.com/nvim-lua/popup.nvim'
    Plug 'https://github.com/nvim-lua/plenary.nvim'
    Plug 'https://github.com/junegunn/fzf'
    
    " File explorer
    Plug 'https://github.com/kyazdani42/nvim-tree.lua', { 'on' : 'NvimTreeToggle'}
    Plug 'https://github.com/kyazdani42/nvim-web-devicons'
    Plug 'https://github.com/ruanyl/vim-gh-line'

    " Tim Pope essentials
    Plug 'https://github.com/tpope/vim-commentary'
    Plug 'https://github.com/tpope/vim-fugitive'
    Plug 'https://github.com/tpope/vim-rhubarb'
    Plug 'https://github.com/tpope/vim-unimpaired'
    Plug 'https://github.com/tpope/vim-surround'

    " Telescope
    Plug 'https://github.com/nvim-telescope/telescope.nvim'
    Plug 'https://github.com/nvim-telescope/telescope-symbols.nvim'

    " Language support
    Plug 'https://github.com/google/vim-jsonnet'
    Plug 'https://github.com/hashivim/vim-terraform'
    Plug 'https://github.com/rust-lang/rust.vim'
    Plug 'https://github.com/khaveesh/vim-fish-syntax'
    Plug 'https://github.com/prettier/vim-prettier'
    Plug 'https://github.com/fatih/vim-go'

    " Colors and GUI
    Plug 'https://github.com/korsveien/gruvbox-material'

call plug#end()

"------------------
"   PLUGIN CONFIG
"------------------
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.md,*.yaml,*.html,*.toml Prettier

let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1

"------------------
"   MAPPINGS
"------------------
let mapleader = " "
nnoremap <leader><leader> <c-^>                              " Jump to previous buffer
nnoremap <leader>c :e ~/.config/nvim/init.vim<cr>            " Edit config file
nnoremap <leader>s :source ~/.config/nvim/init.vim<cr>       " Edit config file

nnoremap <leader>j :% !jq<cr> :set ft=json<cr>
nnoremap <leader>ho :GBrowse<cr>


nnoremap <c-p> :Telescope find_files<cr>
nnoremap <m-p> :Telescope projects<cr>
nnoremap <c-e> :Telescope buffers<cr>
nnoremap <c-f> :Telescope live_grep<cr>
nnoremap <c-s-f> :Telescope grep_string<cr>
nnoremap <c-l> :nohl<cr>

nnoremap <c-h> :NvimTreeToggle<cr>

nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)

nmap :W :w
nmap :Q :q
nmap :X :x

nnoremap <c-q> :q!<cr>

lua <<EOF

require'config/colors'
require'config/gitsigns'
require'config/nvimtree'
require'config/options'
require'config/statusline'
require'config/telescope'
EOF

