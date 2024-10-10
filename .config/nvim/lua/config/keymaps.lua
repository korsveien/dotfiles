-- Plugins
vim.keymap.set("n", "<C-;>", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", "<C-m>", "<cmd>MinimapToggle<CR>")
vim.keymap.set("n", "gx", "<cmd>Browse<CR>")

vim.cmd [[
let mapleader = " "
nnoremap <leader><leader> <c-^>                              " Jump to previous buffer
nnoremap <leader>c :e ~/.config/nvim/init.lua<cr>            " Edit config file
nnoremap <leader>s :source ~/.config/nvim/init.lua<cr>       " Edit config file

nnoremap <leader>j :% !jq<cr> :set ft=json<cr>
nnoremap <leader>ho :GBrowse<cr>


nnoremap <c-p> :Telescope find_files<cr>
nnoremap <c-e> :Telescope git_status<cr>
nnoremap <c-s-f> :Telescope live_grep<cr>
nnoremap <c-f> :Telescope grep_string<cr>

nnoremap <c-l> :nohl<cr>

nnoremap <c-h> :NvimTreeToggle<cr>

" Shortcuts for fat fingers
nmap :W :w
nmap :Q :q
nmap :X :x
nmap :Vs :vs
nmap :Sp :sp
nmap :Make :make

nnoremap <c-q> :q!<cr>

nnoremap :make :make!

"let g:minimap_width = 10
let g:minimap_auto_start = 0
"let g:minimap_auto_start_win_enter = 1
let g:minimap_left = 0
let g:minimap_block_buftypes = ['nofile', 'nowrite', 'quickfix', 'terminal', 'prompt']
let g:minimap_block_filetypes = ['fugitive', 'nerdtree', 'tagbar', 'fzf', 'nvimtree' ]
let g:minimap_git_colors = 1

let g:gh_line_map = '<leader>ho'
]]
