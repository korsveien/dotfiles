return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "github/copilot.vim",
  },
  strategies = {
    chat = {
      adapter = "copilot",
      slash_commands = {
        ["file"] = {
          callback = "strategies.chat.slash_commands.file",
          description = "Select a file using Telescope",
          opts = {
            provider = "telescope",
            contains_code = true,
          },
        },
      },
    },
    inline = {
      adapter = "copilot",
    },
  },
  opts = {
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = "Prompt ",
        provider = "telescope",
        opts = {
          show_default_actions = true,
          show_default_prompt_library = true,
        },
      },
    },
  },
}
