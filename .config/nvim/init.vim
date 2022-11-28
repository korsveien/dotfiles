autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWinEnter * if &filetype == 'help' | wincmd L | endif

set clipboard& clipboard^=unnamed,unnamedplus

"------------------
"     PLUGINS
"------------------
call plug#begin(stdpath('data') . '/plugged')


    Plug 'https://github.com/vim-test/vim-test'
    Plug 'https://github.com/tyru/open-browser.vim'
    Plug 'https://github.com/terryma/vim-multiple-cursors'
    Plug 'https://github.com/karb94/neoscroll.nvim'
    Plug 'https://github.com/lewis6991/gitsigns.nvim'

    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

    " Utility libraries
    Plug 'https://github.com/nvim-lua/popup.nvim'
    Plug 'https://github.com/nvim-lua/plenary.nvim'
    Plug 'https://github.com/junegunn/fzf'
    
    " File explorer
    Plug 'https://github.com/kyazdani42/nvim-tree.lua', { 'on' : 'NvimTreeToggle'}
    Plug 'https://github.com/kyazdani42/nvim-web-devicons'
    Plug 'https://github.com/ruanyl/vim-gh-line'
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
    Plug 'https://github.com/axkirillov/easypick.nvim'

    " LSP and autocompletion
    " Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Plug 'https://github.com/neovim/nvim-lspconfig'
    " Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
    " Plug 'https://github.com/hrsh7th/cmp-buffer'
    " Plug 'https://github.com/hrsh7th/cmp-path'
    " Plug 'https://github.com/hrsh7th/cmp-cmdline'
    " Plug 'https://github.com/hrsh7th/nvim-cmp'
    " Plug 'https://github.com/hrsh7th/vim-vsnip'
    " Plug 'https://github.com/rafamadriz/friendly-snippets'
    " Plug 'https://github.com/kosayoda/nvim-lightbulb'
    " Plug 'https://github.com/antoinemadec/FixCursorHold.nvim'

    " Language support
    Plug 'https://github.com/google/vim-jsonnet'
    Plug 'https://github.com/hashivim/vim-terraform'
    Plug 'https://github.com/rust-lang/rust.vim'
    Plug 'https://github.com/khaveesh/vim-fish-syntax'
    Plug 'https://github.com/prettier/vim-prettier'
    Plug 'https://github.com/fatih/vim-go'

    " Colors and GUI
    Plug 'https://github.com/wfxr/minimap.vim'
    Plug 'https://github.com/korsveien/gruvbox-material'
    Plug 'https://github.com/chentoast/marks.nvim'

call plug#end()

"------------------
"   PLUGIN CONFIG
"------------------
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.md,*.yaml,*.html Prettier



let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_url_maxsave = 0

" vim-test
" nmap <silent> <leader>t :TestNearest<CR>
" nmap <silent> <leader>T :TestFile<CR>
" nmap <silent> <leader>l :TestLast<CR>
let test#strategy = 'neovim'
"let test#neovim#term_position = "vert"
let test#neovim#start_normal = 1

let g:terraform_fmt_on_save = 1

let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1

" Hide statusline in NvimTree
au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree_1" | set laststatus=0 | else | set laststatus=2 | endif

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
nnoremap <c-g> :Telescope grep_string<cr>
nnoremap <m-s> :Telescope git_status<cr>
nnoremap <c-l> :nohl<cr>

nnoremap <c-h> :NvimTreeToggle<cr>
nnoremap <c-s> :NV<CR>

nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)

nmap :W :w
nmap :Q :q
nmap :X :x

nnoremap <c-q> :q!<cr>

lua <<EOF

require'config/colors'
require'config/gitsigns'
--require'config/lsp'
require'config/marks'
require'config/nvimtree'
require'config/options'
require'config/statusline'
require'config/telescope'
--require'config/treesitter'
require'config/project'
EOF

