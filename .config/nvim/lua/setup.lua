require('bufferline').setup{}

require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true, -- false will disable the whole extension
    }
}

require'nvim-tree'.setup{
    open_on_setup = true,
    auto_close = true,
    update_focused_file = {
        enable = true
    },
    view = {
        auto_resize = true
    }
}

local actions = require('telescope.actions')

require('telescope').setup{
    defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            }
        },
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        file_ignore_patterns = {
            "node_modules",
            "plugged",
            "target",
        }
    },
    pickers = {
        find_files = {
            layout_strategy = "center",
            previewer = false
        }
    }
}

require('gitsigns').setup {
    signs = {
        add = { hl = 'GitGutterAdd', text = '+' },
        change = { hl = 'GitGutterChange', text = '~' },
        delete = { hl = 'GitGutterDelete', text = '_' },
        topdelete = { hl = 'GitGutterDelete', text = '‾' },
        changedelete = { hl = 'GitGutterChange', text = '~' },
    },
}

-- Notes
vim.g.nv_search_paths = { '~/Jottacloud/notes' }
