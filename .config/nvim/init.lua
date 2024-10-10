require'config/plugins'

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
require'config/keymaps'

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

require "lsp_signature".setup{}

require("gx").setup{
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
}
