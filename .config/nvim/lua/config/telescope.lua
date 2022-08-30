local actions = require("telescope.actions")

-- vim.api.nvim_set_keymap('n', '<c-f>',
--     '<cmd>lua require(\'telescope.builtin\').grep_string({search = vim.fn.expand("<cword>")})<cr>', {})
--
-- vim.api.nvim_set_keymap('n', '<c-f>', '<cmd>Telescope live_grep<cr>')

require('telescope').load_extension('projects')

require 'telescope'.setup({
    defaults = {
        prompt_prefix = "  ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        mappings = {
            i = {
                ["<C-[>"] = actions.close,
                ["<esc>"] = actions.close,
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
            ".git",
            "pkg",
        },
    },
    pickers = {
        find_files = {
            layout_strategy = "center",
            previewer = false,
            hidden = true,
        },
        marks = {
            layout_strategy = "center",
            previewer = false,
            hidden = true,
        },
        buffers = {
            layout_strategy = "center",
            previewer = false,
            hidden = true,
        },
        lsp_document_symbols = {
            layout_strategy = "center",
            previewer = false,
            hidden = true,
        },
    },
})
