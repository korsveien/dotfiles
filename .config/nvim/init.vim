autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}
autocmd BufWritePre *.tf,*.go,*.vim lua vim.lsp.buf.formatting()
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWinEnter * if &filetype == 'help' | wincmd L | endif

"------------------
"     PLUGINS
"------------------
call plug#begin(stdpath('data') . '/plugged')
    Plug 'pederpus/gruvbox-material'
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
    Plug 'karb94/neoscroll.nvim'
    Plug 'rust-lang/rust.vim'
    Plug 'khaveesh/vim-fish-syntax'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'google/vim-jsonnet'
    Plug 'jiangmiao/auto-pairs'
    Plug 'hashivim/vim-terraform'
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
"   STATUSLINE
"------------
" set statusline+=%f " Show file path
" set statusline+=%m " Show modified state
" set statusline+=%= " Left/Right separator
" set statusline+=%l,
" set statusline+=%c
" set statusline+=\ %{fugitive#statusline()}\  " Display current git branch

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

------------------
--  NVIM CMP
------------------
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },

    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    }),

sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
}, {
    { name = 'buffer' },
})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
}, {
    { name = 'buffer' },
})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
mapping = cmp.mapping.preset.cmdline(),
sources = {
    { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
    { name = 'path' }
}, {
    { name = 'cmdline' }
})
})


-- NvimTree config
require("nvim-tree").setup({
  open_on_setup = true,
  update_focused_file = {
    enable = true,
  },
  view = {
    adaptive_size = true,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 300,
  },
  renderer = {
      full_name = true
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
