local prettier = { "prettier" }

require('conform').setup({
    formatters_by_ft = {
        javascript      = prettier,
        javascriptreact = prettier,
        typescript      = prettier,
        typescriptreact = prettier,
        json            = prettier,
        jsonc           = prettier,
        css             = prettier,
        scss            = prettier,
        html            = prettier,
        yaml            = prettier,
        markdown        = prettier,
        python          = { "ruff_format" },
        kotlin          = { "ktlint" },
    },
    formatters = {
        -- Only run prettier in projects that have a prettier config
        prettier = {
            require_cwd = true,
        },
    },
    -- Falls back to the LSP when no formatter above is available (e.g. rust, lua)
    format_on_save = {
        timeout_ms = 3000,
        lsp_format = "fallback",
    },
})
