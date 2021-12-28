-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/peder/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/peder/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/peder/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/peder/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/peder/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\2¯\2\0\0\4\0\16\0\0194\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\14\0003\2\4\0003\3\3\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\0023\3\n\0:\3\v\0023\3\f\0:\3\r\2:\2\15\1>\0\2\1G\0\1\0\nsigns\1\0\0\17changedelete\1\0\2\ttext\6~\ahl\20GitGutterChange\14topdelete\1\0\2\ttext\bâ€¾\ahl\20GitGutterDelete\vdelete\1\0\2\ttext\6_\ahl\20GitGutterDelete\vchange\1\0\2\ttext\6~\ahl\20GitGutterChange\badd\1\0\0\1\0\2\ttext\6+\ahl\17GitGutterAdd\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/gruvbox",
    url = "https://github.com/morhetz/gruvbox"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\1\2h\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\1>\0\2\1G\0\1\0\rmappings\1\0\0\1\6\0\0\n<C-u>\n<C-d>\azt\azz\azb\nsetup\14neoscroll\frequire\0" },
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\1\2\1\0\0\3\0\b\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\1>\0\2\1G\0\1\0\tview\1\0\1\16auto_resize\2\24update_focused_file\1\0\1\venable\2\1\0\2\15auto_close\2\18open_on_setup\1\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["open-browser.vim"] = {
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/open-browser.vim",
    url = "https://github.com/tyru/open-browser.vim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["telescope.nvim"] = {
    config = { '\27LJ\1\2’\4\0\0\a\0\25\0"4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0027\1\3\0013\2\19\0003\3\4\0003\4\f\0003\5\6\0007\6\5\0:\6\a\0057\6\b\0:\6\t\0057\6\n\0:\6\v\5:\5\r\0043\5\14\0007\6\b\0:\6\t\0057\6\n\0:\6\v\5:\5\15\4:\4\16\0033\4\17\0:\4\18\3:\3\20\0023\3\22\0003\4\21\0:\4\23\3:\3\24\2>\1\2\1G\0\1\0\fpickers\15find_files\1\0\0\1\0\2\14previewer\1\20layout_strategy\vcenter\rdefaults\1\0\0\25file_ignore_patterns\1\4\0\0\17node_modules\fplugged\vtarget\rmappings\6n\1\0\0\6i\1\0\0\n<C-k>\28move_selection_previous\n<C-j>\24move_selection_next\n<esc>\1\0\0\nclose\1\0\6\17entry_prefix\a  \21sorting_strategy\14ascending\18prompt_prefix\v ï€‚  \17initial_mode\vinsert\20layout_strategy\rvertical\20selection_caret\a  \nsetup\14telescope\22telescope.actions\frequire\0' },
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-autoformat"] = {
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/vim-autoformat",
    url = "https://github.com/vim-autoformat/vim-autoformat"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-multiple-cursors"] = {
    loaded = true,
    path = "/home/peder/.local/share/nvim/site/pack/packer/start/vim-multiple-cursors",
    url = "https://github.com/terryma/vim-multiple-cursors"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
try_loadstring("\27LJ\1\2h\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\1>\0\2\1G\0\1\0\rmappings\1\0\0\1\6\0\0\n<C-u>\n<C-d>\azt\azz\azb\nsetup\14neoscroll\frequire\0", "config", "neoscroll.nvim")
time([[Config for neoscroll.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring('\27LJ\1\2’\4\0\0\a\0\25\0"4\0\0\0%\1\1\0>\0\2\0024\1\0\0%\2\2\0>\1\2\0027\1\3\0013\2\19\0003\3\4\0003\4\f\0003\5\6\0007\6\5\0:\6\a\0057\6\b\0:\6\t\0057\6\n\0:\6\v\5:\5\r\0043\5\14\0007\6\b\0:\6\t\0057\6\n\0:\6\v\5:\5\15\4:\4\16\0033\4\17\0:\4\18\3:\3\20\0023\3\22\0003\4\21\0:\4\23\3:\3\24\2>\1\2\1G\0\1\0\fpickers\15find_files\1\0\0\1\0\2\14previewer\1\20layout_strategy\vcenter\rdefaults\1\0\0\25file_ignore_patterns\1\4\0\0\17node_modules\fplugged\vtarget\rmappings\6n\1\0\0\6i\1\0\0\n<C-k>\28move_selection_previous\n<C-j>\24move_selection_next\n<esc>\1\0\0\nclose\1\0\6\17entry_prefix\a  \21sorting_strategy\14ascending\18prompt_prefix\v ï€‚  \17initial_mode\vinsert\20layout_strategy\rvertical\20selection_caret\a  \nsetup\14telescope\22telescope.actions\frequire\0', "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\1\2¯\2\0\0\4\0\16\0\0194\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\14\0003\2\4\0003\3\3\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\0023\3\n\0:\3\v\0023\3\f\0:\3\r\2:\2\15\1>\0\2\1G\0\1\0\nsigns\1\0\0\17changedelete\1\0\2\ttext\6~\ahl\20GitGutterChange\14topdelete\1\0\2\ttext\bâ€¾\ahl\20GitGutterDelete\vdelete\1\0\2\ttext\6_\ahl\20GitGutterDelete\vchange\1\0\2\ttext\6~\ahl\20GitGutterChange\badd\1\0\0\1\0\2\ttext\6+\ahl\17GitGutterAdd\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\1\2\1\0\0\3\0\b\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\1>\0\2\1G\0\1\0\tview\1\0\1\16auto_resize\2\24update_focused_file\1\0\1\venable\2\1\0\2\15auto_close\2\18open_on_setup\1\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
