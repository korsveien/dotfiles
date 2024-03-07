" autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWinEnter * if &filetype == 'help' | wincmd L | endif

autocmd FileType sql setl formatprg=/usr/local/bin/pg_format\ -
"autocmd BufWritePre *.sql :% !pg_format

set clipboard& clipboard^=unnamed,unnamedplus


autocmd FileType swift autocmd BufWritePost *.swift :silent exec "!swiftformat %"

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
    Plug 'https://github.com/fatih/vim-go'
    Plug 'https://github.com/windwp/nvim-autopairs'

    " Asciidoc
    Plug 'https://github.com/habamax/vim-asciidoctor'
    Plug 'https://github.com/shuntaka9576/preview-asciidoc.vim'
    Plug 'https://github.com/vim-denops/denops.vim'

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

    " Colors and GUI
    Plug 'https://github.com/chentoast/marks.nvim'
    Plug 'https://github.com/korsveien/gruvbox-material'

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
nnoremap <c-f> :Telescope live_grep<cr>
nnoremap <c-s-f> :Telescope grep_string<cr>

nnoremap <c-l> :nohl<cr>

nnoremap <c-h> :NvimTreeToggle<cr>

nmap gx <Plug>(openbrowser-open)
vmap gx <Plug>(openbrowser-open)

nmap :W :w
nmap :Q :q
nmap :X :x
nmap :Vs :vs
nmap :Sp :sp
nmap :Make :make

nnoremap <c-q> :q!<cr>

lua <<EOF

require'config/colors'
require'config/gitsigns'
require'config/marks'
require'config/nvimtree'
require'config/options'
require'config/statusline'
require'config/telescope'
-- require'config/treesitter'
require'config/cmp'
require'config/lsp'
require("nvim-autopairs").setup {}
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "jsonls", "tsserver", "denols"}
}
require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
vim.keymap.set("n", "<C-l>", "<cmd>AerialToggle!<CR>")
EOF

