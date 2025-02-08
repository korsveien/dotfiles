return {
  {
    "https://github.com/williamboman/mason.nvim",
    priority = 100,
  },
  {
    "https://github.com/williamboman/mason-lspconfig.nvim",
    priority = 200,
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "terraformls",
      "tflint",
      "tsserver",
    },
  },
  {
    "https://github.com/neovim/nvim-lspconfig",
    priority = 300,
  },
  {
    "https://github.com/saghen/blink.cmp",
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
