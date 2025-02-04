return {
  {
    "https://github.com/williamboman/mason.nvim",
  },

  {
    "https://github.com/williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end,
  },

  {
    "https://github.com/neovim/nvim-lspconfig",
  },

  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "enter",
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "buffer", "codecompanion" },
        cmdline = {}, -- Disable sources for command-line mode
      },
    },
  },
}
