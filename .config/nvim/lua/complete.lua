require('compe').setup({
    enables = true,
    preselect = 'always',
    max_abbr_width = 45,
    source = {
        path = true,
        buffer = true,
        spell = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        treesitter = true,
    },
})

do
    local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t('<C-n>')
        elseif vim.fn.call('vsnip#jumpable', { 1 }) == 1 then
            return t('<Plug>(vsnip-jump-next)')
        else
            return t('<Tab>')
        end
    end

    _G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
            return t('<C-p>')
        elseif vim.fn.call('vsnip#jumpable', { -1 }) == 1 then
            return t('<Plug>(vsnip-jump-prev)')
        else
            return t('<S-Tab>')
        end
    end

    _G.enter_with_snippets = function()
        local autocompleteOpen = vim.fn.pumvisible() == 1
        local autocompleteSelected = isAutocompleteSelected()

        if not autocompleteSelected and autocompleteOpen then
            vim.fn['compe#close']('<C-e>')
        elseif vim.api.nvim_eval([[ vsnip#expandable() ]]) == 1 then
            return t('<Plug>(vsnip-expand)')
        else
            return vim.fn['compe#confirm']('\n')
        end
    end
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
