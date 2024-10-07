" autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWinEnter * if &filetype == 'help' | wincmd L | endif

autocmd FileType sql setlocal formatprg=/usr/local/bin/pg_format\ -
"autocmd BufWritePre *.sql :% !pg_format

autocmd FileType typescript setlocal makeprg=ts-node\ %

set clipboard& clipboard^=unnamed,unnamedplus


autocmd FileType swift autocmd BufWritePost *.swift :silent exec "!swiftformat %"

"------------------
"     PLUGINS
"------------------
call plug#begin(stdpath('data') . '/plugged')

    Plug 'https://github.com/terryma/vim-multiple-cursors'
    Plug 'https://github.com/karb94/neoscroll.nvim'
    Plug 'https://github.com/lewis6991/gitsigns.nvim'

    " Utility libraries
    Plug 'https://github.com/nvim-lua/popup.nvim'
    Plug 'https://github.com/nvim-lua/plenary.nvim'

    " File explorer
    Plug 'https://github.com/kyazdani42/nvim-tree.lua', { 'on' : 'NvimTreeToggle'}
    Plug 'https://github.com/kyazdani42/nvim-web-devicons'
    Plug 'https://github.com/ruanyl/vim-gh-line'
    Plug 'https://github.com/chrishrb/gx.nvim'

    " Tim Pope essentials
    Plug 'https://github.com/tpope/vim-fugitive'
    Plug 'https://github.com/tpope/vim-rhubarb'
    Plug 'https://github.com/tpope/vim-unimpaired'
    Plug 'https://github.com/tpope/vim-surround'

    " Junegunn essentiasls
    Plug 'https://github.com/junegunn/vim-easy-align'
    Plug 'https://github.com/junegunn/fzf'

    " Telescope
    Plug 'https://github.com/nvim-telescope/telescope.nvim'
    Plug 'https://github.com/nvim-telescope/telescope-symbols.nvim'

    " Treesitter
    Plug 'https://github.com/nvim-treesitter/nvim-treesitter'
    Plug 'https://github.com/nvim-treesitter/nvim-treesitter-context', {'do': ':TSUpdate'}

    " Language support
    Plug 'https://github.com/google/vim-jsonnet'
    Plug 'https://github.com/hashivim/vim-terraform'
    Plug 'https://github.com/rust-lang/rust.vim'
    Plug 'https://github.com/khaveesh/vim-fish-syntax'


    " LSP, Autocompletion and snippets
    Plug 'https://github.com/neovim/nvim-lspconfig'
    Plug 'https://github.com/hrsh7th/nvim-cmp/'
    Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
    Plug 'https://github.com/hrsh7th/cmp-path'
    Plug 'https://github.com/hrsh7th/cmp-cmdline'
    Plug 'https://github.com/hrsh7th/cmp-buffer'
    Plug 'https://github.com/onsails/lspkind.nvim'
    Plug 'https://github.com/williamboman/mason.nvim'
    Plug 'https://github.com/williamboman/mason-lspconfig.nvim'
    Plug 'https://github.com/folke/trouble.nvim'
    Plug 'https://github.com/stevearc/aerial.nvim'
    Plug 'https://github.com/windwp/nvim-autopairs'
    Plug 'https://github.com/ray-x/lsp_signature.nvim'

    " Colors and GUI
    Plug 'https://github.com/chentoast/marks.nvim'
    Plug 'https://github.com/korsveien/gruvbox-material'
    Plug 'https://github.com/wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}

call plug#end()

"------------------
"   PLUGIN CONFIG
"------------------
"autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.md,*.yaml,*.html Prettier

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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
nnoremap <c-e> :Telescope git_status<cr>
nnoremap <c-s-f> :Telescope live_grep<cr>
nnoremap <c-f> :Telescope grep_string<cr>

nnoremap <c-l> :nohl<cr>

nnoremap <c-h> :NvimTreeToggle<cr>

" Shortcuts for fat fingers
nmap :W :w
nmap :Q :q
nmap :X :x
nmap :Vs :vs
nmap :Sp :sp
nmap :Make :make

nnoremap <c-q> :q!<cr>

nnoremap :make :make!

nnoremap gx :Browse<cr>

"let g:minimap_width = 10
let g:minimap_auto_start = 0
"let g:minimap_auto_start_win_enter = 1
let g:minimap_left = 0
let g:minimap_block_buftypes = ['nofile', 'nowrite', 'quickfix', 'terminal', 'prompt']
let g:minimap_block_filetypes = ['fugitive', 'nerdtree', 'tagbar', 'fzf', 'nvimtree' ]
let g:minimap_git_colors = 1

lua <<EOF

-- https://www.mukeshsharma.dev/2022/02/08/neovim-workflow-for-terraform.html
-- autoformat terraform files
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

-- automatically format *.tf and *.tfvars files with terraform fmt on save and align settings.
vim.cmd([[let g:terraform_fmt_on_save=1]])
vim.cmd([[let g:terraform_align=1]])



--

require'config/colors'
require'config/gitsigns'
require'config/marks'
require'config/nvimtree'
require'config/options'
require'config/statusline'
require'config/telescope'
require'config/autocmds'

-- require'config/treesitter'

require'config/cmp'
require'config/lsp'
require("nvim-autopairs").setup {}

-- mason
require("mason").setup{}
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "jsonls",
        "tsserver",
        "gopls",
        "yamlls",
        "terraformls",
        "tflint",
        "bashls",
    }
}

require("aerial").setup{}
vim.keymap.set("n", "<C-;>", "<cmd>AerialToggle!<CR>")

require "lsp_signature".setup{}

require("gx").setup{
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
}

EOF

