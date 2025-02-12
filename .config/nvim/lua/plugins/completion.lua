return {
  {
    "https://github.com/williamboman/mason.nvim",
    opts = {},
    lazy = false,
    priority = 100,
  },
  {
    "https://github.com/williamboman/mason-lspconfig.nvim",
    lazy = false,
    priority = 200,
    ensure_installed = {
      "lua_ls",
      "rust_analyzer",
      "terraformls",
      "tflint",
      "tsserver",
      "prettier",
      "rustfmt",
      "stylua",
      "shfmt",
      "fish_indent",
    },
  },
  {
    "https://github.com/neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")

      -- Start lua_ls config
      lspconfig["lua_ls"].setup({
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath("config")
              and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
            then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              },
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              -- library = vim.api.nvim_get_runtime_file("", true)
            },
          })
        end,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      -- End lua_ls config

      lspconfig["rust_analyzer"].setup({})
      lspconfig["gopls"].setup({})
      lspconfig["terraformls"].setup({})
    end,
    priority = 300,
  },
  {
    "https://github.com/saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "enter",
        --   ["<S-Tab>"] = { "select_prev", "fallback" },
        --   ["<Tab>"] = { "select_next", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "buffer", "codecompanion" },
        cmdline = {}, -- Disable sources for command-line mode
      },
    },
  },
}
