require('packer').startup(function(use)
    use('wbthomason/packer.nvim')

    use({ 'tyru/open-browser.vim' })
    vim.cmd([[
    let g:netrw_nogx = get(g:, 'netrw_nogx', 1)
    nmap gx <Plug>(openbrowser-open)
    vmap gx <Plug>(openbrowser-open)
    ]])

    -- lsp
    use('neovim/nvim-lspconfig')
    use('williamboman/nvim-lsp-installer')

    use({
        'ray-x/lsp_signature.nvim',
        config = function()
            require('lsp_signature').on_attach()
        end,
    })
    use('folke/lsp-colors.nvim')
    use({
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup({
                auto_open = false,
                auto_close = true,
                use_lsp_diagnostic_signs = true,
            })
        end,
    })

    -- dap
    use('mfussenegger/nvim-dap')

    -- completion
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use({
        'hrsh7th/nvim-cmp',
        config = function()
            require('complete')
        end,
    })

    use({
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
        config = function()
            local actions = require('telescope.actions')

            require('telescope').setup({
                defaults = {
                    prompt_prefix = '   ',
                    selection_caret = '  ',
                    entry_prefix = '  ',
                    initial_mode = 'insert',
                    mappings = {
                        i = {
                            ['<esc>'] = actions.close,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                        },
                        n = {
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                        },
                    },
                    sorting_strategy = 'ascending',
                    layout_strategy = 'vertical',
                    file_ignore_patterns = {
                        'node_modules',
                        'plugged',
                        'target',
                    },
                },
                pickers = {
                    find_files = {
                        layout_strategy = 'center',
                        previewer = false,
                    },
                },
            })
        end,
    })

    -- languages
    use({
        'plasticboy/vim-markdown',
        ft = { 'markdown' },
        disable = true,
        config = function()
            -- disable the folding configuration
            vim.g.vim_markdown_folding_disabled = 1
            -- enable conceal
            vim.g.vim_markdown_conceal = 1
            -- Latex math syntax
            vim.g.vim_markdown_math = 1
            -- Strikethrough uses two tildes
            vim.g.vim_markdown_strikethrough = 1
            -- Enable TOC Autofit
            vim.g.vim_markdown_toc_autofit = 1
        end,
    })
    use({
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        ft = { 'markdown' },
    })

    -- git
    use({
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('gitsigns').setup({
                signs = {
                    add = { hl = 'GitGutterAdd', text = '+' },
                    change = { hl = 'GitGutterChange', text = '~' },
                    delete = { hl = 'GitGutterDelete', text = '_' },
                    topdelete = { hl = 'GitGutterDelete', text = '‾' },
                    changedelete = { hl = 'GitGutterChange', text = '~' },
                },
            })
        end,
    })
    use('tpope/vim-fugitive')
    use({ 'tpope/vim-rhubarb', requires = 'tpope/vim-fugitive' })

    -- ui
    use('kyazdani42/nvim-web-devicons')

    use({
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'vscode',
                    section_separators = { '', '' },
                    component_separators = { '', '' },
                },
            })
        end,
    })

    -- explorer
    use({
        'kyazdani42/nvim-tree.lua',
        requires = {
            { 'kyazdani42/nvim-web-devicons' },
            { 'lewis6991/gitsigns.nvim' },
        },
        config = function()
            require('nvim-tree').setup({
                open_on_setup = true,
                auto_close = false,
                update_focused_file = {
                    enable = true,
                },
                view = {
                    auto_resize = true,
                },
            })
        end,
    })

    vim.cmd([[
    let g:nvim_tree_special_files = {}
    let g:nvim_tree_disable_window_picker = 1
    let g:nvim_tree_show_icons = {
        \ 'git': 0,
        \ 'folders': 1,
        \ 'files': 1,
        \ 'folder_arrows': 1,
        \}
        ]])

    -- notes
    use({ 'alok/notational-fzf-vim', requires = 'junegunn/fzf' })
    vim.cmd("let g:nv_search_paths = ['~/Jottacloud/notes']")

    -- editing
    use('tpope/vim-commentary')
    use('terryma/vim-multiple-cursors')
    use('vim-autoformat/vim-autoformat')
    use({
        'windwp/nvim-autopairs',
        config = function()
            require('pairs')
        end,
    })
    use({ 'junegunn/vim-easy-align' })
    vim.cmd([[ vmap ga <Plug>(EasyAlign) ]])

    -- color and syntax
    use('Mofiqul/vscode.nvim')

    use('mboughaba/i3config.vim')
    use({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = 'maintained', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                highlight = {
                    enable = true, -- false will disable the whole extension
                },
            })
        end,
    })

    -- utils
    use({
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup()
        end,
    })
    use({
        'karb94/neoscroll.nvim',
        config = function()
            require('neoscroll').setup({
                mappings = { '<C-u>', '<C-d>', 'zt', 'zz', 'zb' },
            })
        end,
    })
end)
