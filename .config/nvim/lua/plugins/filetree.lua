return {
  {
    "https://github.com/nvim-tree/nvim-tree.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
    opts = {
      sync_root_with_cwd = false,
      respect_buf_cwd = false,
      update_focused_file = {
        enable = true,
        update_root = {
          enable = false,
        },
      },
      view = {
        adaptive_size = true,
        signcolumn = "no",
        centralize_selection = false,
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 300,
      },
      renderer = {
        root_folder_label = false,
        full_name = true,
        highlight_git = true,
        root_folder_modifier = ":.",
        icons = {
          glyphs = {
            git = {
              ignored = "",
              staged = "",
              unstaged = "",
              untracked = "",
            },
          },
        },
      },
      filesystem_watchers = {
        enable = true,
      },
    },
  },
}
