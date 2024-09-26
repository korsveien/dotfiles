-- Setup language servers.
--
-- To see the features of the LSP server, run:
-- :lua print(vim.inspect(vim.lsp.protocol.make_client_capabilities()))
--
local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.format() end
    })
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if vim.tbl_contains({ 'null-ls' }, client.name) then  -- blacklist lsp
      return
    end
    require("lsp_signature").on_attach({
      -- ... setup options here ...
    }, bufnr)
  end,
})

-- require('lspconfig.configs').postgres_lsp = {
--   default_config = {
--     name = 'postgres_lsp',
--     cmd = {'postgres_lsp'},
--     filetypes = {'sql'},
--     single_file_support = true,
--     root_dir = util.root_pattern 'root-file.txt'
--   }
-- }
--
-- lspconfig.configure("postgres_lsp", {force_setup = true})

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

require'lspconfig'.terraformls.setup{}
require'lspconfig'.tflint.setup{}

-- https://github.com/golang/tools/tree/master/gopls
lspconfig.gopls.setup({})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})

lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {},
  },
}

lspconfig.yamlls.setup{
  on_attach = on_attach,
  settings = {
    yaml = {
      schemas = {
        kubernetes = "/*.k.yaml", -- Example of setting up schema for Kubernetes files
      },
      validate = true, -- Enable YAML validation
    },
  }
}

-- lspconfig.jsonnet_ls.setup{
-- 	settings = {
-- 		ext_vars = {
-- 			-- foo = 'bar',
-- 		},
-- 		formatting = {
-- 			-- default values
-- 			Indent              = 2,
-- 			MaxBlankLines       = 2,
-- 			StringStyle         = 'single',
-- 			CommentStyle        = 'slash',
-- 			PrettyFieldNames    = true,
-- 			PadArrays           = false,
-- 			PadObjects          = true,
-- 			SortImports         = true,
-- 			UseImplicitPlus     = true,
-- 			StripEverything     = false,
-- 			StripComments       = false,
-- 			StripAllButComments = false,
-- 		},
-- 	},
-- }

-- TypeScript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

