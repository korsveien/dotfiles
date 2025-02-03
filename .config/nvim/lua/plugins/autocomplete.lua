return {
    { "williamboman/mason.nvim", opts = {
        ensure_installed = "lua_ls",
        "rust_analyzer",
    } },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },
    {
        -- https://codecompanion.olimorris.dev
        "olimorris/codecompanion.nvim",
        strategies = {
            chat = {
                adapter = "copilot",
            },
            inline = {
                adapter = "copilot",
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "github/copilot.vim",
        },
    },
    {
        "https://github.com/saghen/blink.cmp",
        version = "*",
        opts = {
            keymap = {
                preset = "enter",
                -- ["<Tab>"] = {"select_next", "fallback"},
                -- ["<S-Tab>"] = {"select_prev", "fallback"},
            },
            completion = {
                accept = {
                    auto_brackets = {
                        enabled = true,
                    },
                },
                menu = {
                    -- Disable autocomplete when in cmdline mode
                    -- auto_show = function(ctx)
                    --     return ctx.mode ~= "cmdline"
                    -- end,
                },
            },
        },
    },
}
