-- A subtle colorscheme based on Kanagawa Dragon
-- Uses fewer colors for a calmer editing experience

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "sekigawa"
vim.o.background = "dark"

-- Kanagawa Dragon palette (subset)
local c = {
  -- Backgrounds
  bg        = "#181616",
  bg_dim    = "#1D1C19",
  bg_float  = "#1D1C19",
  bg_visual = "#2D4F67",
  bg_search = "#2D4F67",

  -- Foregrounds
  fg        = "#c5c9c5",
  fg_dim    = "#737c73",

  -- Accents (minimal set)
  green     = "#8a9a7b",
  yellow    = "#c4b28a",
  blue      = "#8ba4b0",

  -- UI
  border    = "#2a2a2a",
  comment   = "#727169",
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor UI
hi("Normal",       { fg = c.fg, bg = c.bg })
hi("NormalFloat",  { fg = c.fg, bg = c.bg_float })
hi("FloatBorder",  { fg = c.border, bg = c.bg_float })
hi("Cursor",       { fg = c.bg, bg = c.fg })
hi("CursorLine",   { bg = c.bg_dim })
hi("CursorLineNr", { fg = c.fg, bold = true })
hi("LineNr",       { fg = c.fg_dim })
hi("SignColumn",   { bg = c.bg })
hi("VertSplit",    { fg = c.border })
hi("WinSeparator", { fg = c.border })
hi("StatusLine",   { fg = c.fg, bg = c.bg })
hi("StatusLineNC", { fg = c.fg_dim, bg = c.bg })
hi("TabLine",      { fg = c.fg_dim, bg = c.bg_dim })
hi("TabLineFill",  { bg = c.bg_dim })
hi("TabLineSel",   { fg = c.fg, bg = c.bg, bold = true })
hi("Pmenu",        { fg = c.fg, bg = c.bg_float })
hi("PmenuSel",     { fg = c.fg, bg = c.bg_visual })
hi("PmenuSbar",    { bg = c.bg_dim })
hi("PmenuThumb",   { bg = c.fg_dim })
hi("Visual",       { bg = c.bg_visual })
hi("Search",       { fg = c.fg, bg = c.bg_search })
hi("IncSearch",    { fg = c.bg, bg = c.yellow })
hi("MatchParen",   { fg = c.yellow, bold = true })
hi("NonText",      { fg = c.fg_dim })
hi("SpecialKey",   { fg = c.fg_dim })
hi("Folded",       { fg = c.fg_dim, bg = c.bg_dim })
hi("FoldColumn",   { fg = c.fg_dim, bg = c.bg })
hi("EndOfBuffer",  { fg = c.bg })
hi("Directory",    { fg = c.blue })
hi("Title",        { fg = c.fg, bold = true })
hi("ErrorMsg",     { fg = c.yellow })
hi("WarningMsg",   { fg = c.yellow })
hi("ModeMsg",      { fg = c.fg, bold = true })
hi("MoreMsg",      { fg = c.green })
hi("Question",     { fg = c.blue })
hi("WildMenu",     { fg = c.fg, bg = c.bg_visual })

-- Syntax - The key to subtlety: most things are just fg or fg_dark
hi("Comment",      { fg = c.comment })

hi("Constant",     { fg = c.fg })
hi("String",       { fg = c.green })
hi("Character",    { fg = c.green })
hi("Number",       { fg = c.fg, bold = true })
hi("Boolean",      { fg = c.fg, bold = true })
hi("Float",        { fg = c.fg, bold = true })

hi("Identifier",   { fg = c.fg })
hi("Function",     { fg = c.fg })

hi("Statement",    { fg = c.fg, bold = true })
hi("Conditional",  { fg = c.fg, bold = true })
hi("Repeat",       { fg = c.fg, bold = true })
hi("Label",        { fg = c.fg, bold = true })
hi("Operator",     { fg = c.fg })
hi("Keyword",      { fg = c.fg, bold = true })
hi("Exception",    { fg = c.fg, bold = true })

hi("PreProc",      { fg = c.fg, bold = true })
hi("Include",      { fg = c.fg, bold = true })
hi("Define",       { fg = c.fg, bold = true })
hi("Macro",        { fg = c.fg, bold = true })
hi("PreCondit",    { fg = c.fg, bold = true })

hi("Type",         { fg = c.fg })
hi("StorageClass", { fg = c.fg, bold = true })
hi("Structure",    { fg = c.fg })
hi("Typedef",      { fg = c.fg })

hi("Special",      { fg = c.fg })
hi("SpecialChar",  { fg = c.green })
hi("Tag",          { fg = c.fg })
hi("Delimiter",    { fg = c.fg })
hi("Debug",        { fg = c.yellow })

hi("Underlined",   { underline = true })
hi("Ignore",       { fg = c.fg_dim })
hi("Error",        { fg = c.yellow })
hi("Todo",         { fg = c.yellow, bold = true })

-- Treesitter
hi("@variable",          { fg = c.fg })
hi("@variable.builtin",  { fg = c.fg, bold = true })
hi("@variable.parameter",{ fg = c.fg })
hi("@variable.member",   { fg = c.fg })

hi("@constant",          { fg = c.fg })
hi("@constant.builtin",  { fg = c.fg, bold = true })

hi("@module",            { fg = c.fg })
hi("@label",             { fg = c.fg, bold = true })

hi("@string",            { fg = c.green })
hi("@string.escape",     { fg = c.fg, bold = true })
hi("@string.regexp",     { fg = c.fg, bold = true })

hi("@character",         { fg = c.green })
hi("@number",            { fg = c.fg, bold = true })
hi("@boolean",           { fg = c.fg, bold = true })

hi("@type",              { fg = c.fg })
hi("@type.builtin",      { fg = c.fg, bold = true })
hi("@attribute",         { fg = c.fg, bold = true })
hi("@property",          { fg = c.fg })

hi("@function",          { fg = c.fg })
hi("@function.builtin",  { fg = c.fg })
hi("@function.call",     { fg = c.fg })
hi("@function.method",   { fg = c.fg })
hi("@constructor",       { fg = c.fg })

hi("@keyword",           { fg = c.fg, bold = true })
hi("@keyword.function",  { fg = c.fg, bold = true })
hi("@keyword.operator",  { fg = c.fg })
hi("@keyword.return",    { fg = c.fg, bold = true })

hi("@operator",          { fg = c.fg })
hi("@punctuation",       { fg = c.fg })
hi("@punctuation.bracket",{ fg = c.fg })
hi("@punctuation.delimiter", { fg = c.fg })
hi("@punctuation.special",{ fg = c.fg, bold = true })

hi("@comment",           { fg = c.comment })
hi("@tag",               { fg = c.fg })
hi("@tag.attribute",     { fg = c.fg, bold = true })
hi("@tag.delimiter",     { fg = c.fg })

-- LSP Semantic Tokens
hi("@lsp.type.class",         { link = "@type" })
hi("@lsp.type.decorator",     { link = "@attribute" })
hi("@lsp.type.enum",          { link = "@type" })
hi("@lsp.type.enumMember",    { link = "@constant" })
hi("@lsp.type.function",      { link = "@function" })
hi("@lsp.type.interface",     { link = "@type" })
hi("@lsp.type.macro",         { link = "@macro" })
hi("@lsp.type.method",        { link = "@function.method" })
hi("@lsp.type.namespace",     { link = "@module" })
hi("@lsp.type.parameter",     { link = "@variable.parameter" })
hi("@lsp.type.property",      { link = "@property" })
hi("@lsp.type.struct",        { link = "@type" })
hi("@lsp.type.type",          { link = "@type" })
hi("@lsp.type.variable",      { link = "@variable" })

-- Diagnostics
hi("DiagnosticError",         { fg = c.yellow })
hi("DiagnosticWarn",          { fg = c.yellow })
hi("DiagnosticInfo",          { fg = c.blue })
hi("DiagnosticHint",          { fg = c.green })
hi("DiagnosticUnderlineError",{ sp = c.yellow, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.yellow, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = c.blue, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = c.green, undercurl = true })

-- Git signs
hi("GitSignsAdd",    { fg = c.green })
hi("GitSignsChange", { fg = c.yellow })
hi("GitSignsDelete", { fg = c.yellow })
hi("DiffAdd",        { fg = c.green })
hi("DiffChange",     { fg = c.yellow })
hi("DiffDelete",     { fg = c.yellow })
hi("DiffText",       { fg = c.fg, bg = c.bg_visual })

-- Telescope
hi("TelescopeBorder",        { fg = c.border })
hi("TelescopePromptBorder",  { fg = c.border })
hi("TelescopeResultsBorder", { fg = c.border })
hi("TelescopePreviewBorder", { fg = c.border })
hi("TelescopeSelection",     { bg = c.bg_visual })
hi("TelescopeMatching",      { fg = c.yellow })

-- NvimTree
hi("NvimTreeNormal",         { fg = c.fg, bg = c.bg })
hi("NvimTreeFolderIcon",     { fg = c.blue })
hi("NvimTreeFolderName",     { fg = c.fg })
hi("NvimTreeOpenedFolderName", { fg = c.fg })
hi("NvimTreeRootFolder",     { fg = c.fg, bold = true })
hi("NvimTreeSpecialFile",    { fg = c.fg })
hi("NvimTreeGitDirty",       { fg = c.yellow })
hi("NvimTreeGitNew",         { fg = c.green })
hi("NvimTreeGitDeleted",     { fg = c.yellow })
hi("NvimTreeIndentMarker",   { fg = c.border })
