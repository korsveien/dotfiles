require 'project_nvim'.setup {
    patterns = { '.git', 'Makefile' },
    exclude_dirs = { '.cargo/*', 'node_modules/*' },
}
