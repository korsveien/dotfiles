require("mason").setup({
    ensure_installed = {
        "jsonnet-language-server",
        "lua-language-server",
        "yaml-language-server",
    }
})
require("mason-lspconfig").setup()
