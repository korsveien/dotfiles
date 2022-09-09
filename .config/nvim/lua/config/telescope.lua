local actions = require("telescope.actions")

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
            },
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
