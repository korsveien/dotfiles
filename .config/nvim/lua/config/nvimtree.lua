require("nvim-tree").setup({
    open_on_setup = true,
    update_focused_file = {
        enable = true,
    },
    view = {
        adaptive_size = true,
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 300,
    },
    renderer = {
        full_name = true,
        highlight_git = true,
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
