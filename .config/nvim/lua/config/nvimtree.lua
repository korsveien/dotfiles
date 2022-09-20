-- https://github.com/kyazdani42/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt
require("nvim-tree").setup({
    open_on_setup = false,
    sync_root_with_cwd = false,
    respect_buf_cwd = false,
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    view = {
        hide_root_folder = true,
        adaptive_size = true,
        signcolumn = 'no',
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 300,
    },
    renderer = {
        full_name = true,
        highlight_git = true,
        root_folder_modifier = ':.',
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
})
