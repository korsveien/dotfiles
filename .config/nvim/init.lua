local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim --depth 1 ' .. packer_path)
end

require('utils').new_augroup({
    packer_compile = { 'BufWritePost plugins.lua PackerCompile' },
})

vim.cmd([[

highlight Search guibg='Orange' guifg='Black'
highlight NvimTreeOpenedFile guifg=blue gui=bold,underline

nnoremap <C-h> :NvimTreeToggle<CR>
nnoremap <C-j> :TroubleToggle<CR>

""""""""""""""""""""""""""""""""""""""""
"EASYALIGN MAPPINGS
""""""""""""""""""""""""""""""""""""""""
vmap ga <Plug>(EasyAlign)


""""""""""""""""""""""""""""""""""""""""
"BUFFERLINE MAPPINGS
""""""""""""""""""""""""""""""""""""""""
" These commands will navigate through buffers in order regardless of which mode you are using
" e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
nnoremap <silent>[b :BufferLineCycleNext<CR>
nnoremap <silent>]b :BufferLineCyclePrev<CR>

" These commands will sort buffers by directory, language, or a custom criteria
nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>

""""""""""""""""""""""""""""""""""""""""
"AUTOCOMMANDS
""""""""""""""""""""""""""""""""""""""""
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}
au BufWrite *.rs,*.swift,*.tf,*.lua :Autoformat
autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo
autocmd FileType help wincmd L

" Syntax highlight sway config
aug i3config_ft_detection
au!
au BufNewFile,BufRead ~/.config/sway/config set filetype=i3config
aug end
]])

require('plugins')
require('options')
require('lsp')
require('mappings')

-- set colorscheme
vim.cmd([[
let g:vscode_style = "dark"
colorscheme vscode
]])
