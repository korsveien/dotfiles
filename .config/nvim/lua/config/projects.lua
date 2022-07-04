require 'project_nvim'.setup {
    patterns = { '.git', 'Makefile', 'main.tf' },
    exclude_dirs = { '.cargo/*', 'node_modules/*' },
}
