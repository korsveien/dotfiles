vim.cmd [[

call plug#begin(stdpath('data') . '/plugged')
    " Utility libraries
    Plug 'https://github.com/nvim-lua/popup.nvim'
    Plug 'https://github.com/nvim-lua/plenary.nvim'

    " Editing
    Plug 'https://github.com/terryma/vim-multiple-cursors'

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
    Plug 'https://github.com/lewis6991/gitsigns.nvim'

call plug#end()
]]
