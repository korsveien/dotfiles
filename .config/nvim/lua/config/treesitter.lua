require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "lua", "rust", "go", "hcl" },
    sync_install = false,

    highlight = {
        enable = false
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-j>",
            node_incremental = "<C-j>",
            scope_incremental = "<C-s>",
            node_decremental = "<C-k>",
        },
    },

    indent = {
        enable = true
    }
}
