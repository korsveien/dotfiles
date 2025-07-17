local function get_git_status()
  -- use fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
  local is_head_empty = signs.head ~= ""
  return is_head_empty and string.format(" %s", signs.head) or ""
end

local function filename()
  return "%<%10.128F "
end

local function modified_flag()
  return "%m"
end

local function percentage()
  return "%3p%%"
end

local function current_line()
  return "%l"
end

local function current_column()
  return "%c"
end

function LspClients()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    return ""
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return "" .. table.concat(names, ",") .. ""
end

function StatusLine()
  local statusline = ""
  statusline = statusline .. filename()
  statusline = statusline .. modified_flag()
  statusline = statusline .. "%="
  statusline = statusline .. " "
  statusline = statusline .. "%="
  statusline = statusline .. " "
  statusline = statusline .. LspClients()
  statusline = statusline .. " "
  statusline = statusline .. percentage()
  statusline = statusline .. " "
  statusline = statusline .. get_git_status()
  statusline = statusline .. " "

  return statusline
end

vim.o.statusline = "%!luaeval('StatusLine()')"
