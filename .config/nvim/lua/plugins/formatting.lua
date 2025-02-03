return {
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                fish = { "fish_indent" },
                sh = { "shfmt" },
                rust = { "rustfmt" },
            },
            format_on_save = {
                timeout_ms = 500,
                ls_lformat = "fallback",
            },
        },
    },
}
