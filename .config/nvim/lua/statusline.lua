local function get_git_status()
    -- use fallback because it doesn't set this variable on the initial `BufEnter`
    local signs = vim.b.gitsigns_status_dict or { head = '', added = 0, changed = 0, removed = 0 }
    local is_head_empty = signs.head ~= ''
    return is_head_empty and string.format(
        '( %s)', signs.head
    ) or ''
end

local function filename()
    return "%<%10.40F "
end

local function modified_flag()
    return "%m"
end

local function percentage()
    return "%p%%"
end

local function lines_in_buffer()
    return "%L"
end

local function get_active_lsp_clients()
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
        if client ~= nil then
            return '[' .. client.name .. ']'
        end
    end
    return ''
end

function StatusLine()
    local statusline = ""
    statusline = statusline .. filename()
    statusline = statusline .. get_git_status()
    statusline = statusline .. modified_flag()
    statusline = statusline .. "%="
    statusline = statusline .. percentage()
    statusline = statusline .. " L:"
    statusline = statusline .. lines_in_buffer()
    statusline = statusline .. " "
    statusline = statusline .. get_active_lsp_clients()
    statusline = statusline .. " "

    return statusline
end

vim.o.statusline = "%!luaeval('StatusLine()')"
