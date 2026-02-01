-- https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
require("nvim-tree").setup(
  {
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
    },
    view = {
        adaptive_size = true,
        signcolumn = 'no',
        centralize_selection = true,
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 300,
    },
    renderer = {
        full_name = true,
        root_folder_modifier = ':.',
        root_folder_label = false,
        icons = {
            glyphs = {
                git = {
                    ignored = '',
                    staged = '',
                    unstaged = '',
                    untracked = '',
                }
            }
        }
    },
    filesystem_watchers = {
        enable = true
    },
}
)

vim.keymap.set("n", "<C-h>", "<Cmd>NvimTreeToggle<CR>")
