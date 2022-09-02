autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWinEnter * if &filetype == 'help' | wincmd L | endif

set clipboard& clipboard^=unnamed,unnamedplus

"------------------
"     PLUGINS
"------------------
call plug#begin(stdpath('data') . '/plugged')

    Plug 'https://github.com/chentoast/marks.nvim'

    Plug 'https://github.com/vim-test/vim-test'
    Plug 'https://github.com/tyru/open-browser.vim'
    Plug 'https://github.com/terryma/vim-multiple-cursors'
    Plug 'https://github.com/karb94/neoscroll.nvim'
    Plug 'https://github.com/jiangmiao/auto-pairs'
    Plug 'https://github.com/lewis6991/gitsigns.nvim'

    " Utility libraries
    Plug 'https://github.com/nvim-lua/popup.nvim'
    Plug 'https://github.com/nvim-lua/plenary.nvim'
    
    " File explorer
    Plug 'https://github.com/kyazdani42/nvim-tree.lua', { 'on' : 'NvimTreeToggle'}
    Plug 'https://github.com/kyazdani42/nvim-web-devicons'
    Plug 'https://github.com/ahmedkhalf/project.nvim'
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
    Plug 'https://github.com/kosayoda/nvim-lightbulb'

    " Language support
    Plug 'https://github.com/google/vim-jsonnet'
    Plug 'https://github.com/hashivim/vim-terraform'
    Plug 'https://github.com/rust-lang/rust.vim'
    Plug 'https://github.com/khaveesh/vim-fish-syntax'
    Plug 'https://github.com/LnL7/vim-nix'
    Plug 'https://github.com/prettier/vim-prettier'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

    " Notes and documentation
    Plug 'https://github.com/vimwiki/vimwiki'
    Plug 'https://github.com/alok/notational-fzf-vim'
    Plug 'https://github.com/junegunn/fzf'
    Plug 'https://github.com/junegunn/goyo.vim'
    Plug 'https://github.com/junegunn/limelight.vim'

    " Colors
    Plug 'https://github.com/korsveien/gruvbox-material'

call plug#end()

"------------------
"   PLUGIN CONFIG
"------------------
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.md,*.yaml,*.html Prettier
autocmd! User GoyoEnter Limelight
autocmd! User GoyoEnter set wrap
autocmd! User GoyoLeave Limelight!
autocmd! User GoyoLeave set nowrap 

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_url_maxsave = 0
let g:nv_search_paths = ['~/vimwiki/tech/', '~/vimwiki/digipost/']

" vim-test
" nmap <silent> <leader>t :TestNearest<CR>
" nmap <silent> <leader>T :TestFile<CR>
" nmap <silent> <leader>l :TestLast<CR>
let test#strategy = 'neovim'
"let test#neovim#term_position = "vert"
let test#neovim#start_normal = 1


"------------------
"   MAPPINGS
"------------------
let mapleader = " "
nnoremap <leader><leader> <c-^>                              " Jump to previous buffer
nnoremap <leader>c :e ~/.config/nvim/init.vim<cr>            " Edit config file
nnoremap <leader>w :nohl<cr>
nnoremap <leader>j :% !jq<cr> :set ft=json<cr>
nnoremap <leader>t :execute "topleft 10 split ~/vimwiki/todo/" . strftime('%Y-W%W') . ".md"<cr>
nnoremap <leader>s :execute "topleft 10 split ~/vimwiki/scratch/" . strftime('%Y-%m-%d') . ".md"<cr>
nnoremap <leader>m <Plug>MarkdownPreview
nnoremap <leader>y :Goyo<cr>
nnoremap <leader>ho :GBrowse<cr>

nnoremap <c-q> :q!<cr>
nnoremap <c-p> :Telescope find_files<cr>
nnoremap <c-g> :Telescope live_grep<cr>
nnoremap <c-b> :Telescope buffers<cr>
nnoremap <c-`> :Telescope marks<cr>
nnoremap <c-h> :NvimTreeToggle<cr>
nnoremap <silent> <c-s> :NV<CR>
nnoremap <c-f> <cmd>Telescope live_grep<cr>
nnoremap <c-l> <Plug>VimwikiToggleListItem
vnoremap <c-l> <Plug>VimwikiToggleListItem
nnoremap <c-t> :VimwikiTable<cr>
nnoremap <c-k> "_dd



nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)

nmap :W :w
nmap :Q :q
nmap :X :x

lua <<EOF

require'config/colors'
require'config/gitsigns'
require'config/lsp'
require'config/marks'
require'config/nvimtree'
require'config/options'
require'config/projects'
require'config/statusline'
require'config/telescope'
require'config/treesitter'
EOF

