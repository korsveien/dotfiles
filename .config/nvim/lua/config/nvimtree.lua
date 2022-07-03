require("nvim-tree").setup({
    open_on_setup = true,
    update_focused_file = {
        enable = true,
    },
    view = {
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
