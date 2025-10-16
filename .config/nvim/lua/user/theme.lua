-- check some visual colors from https://github.com/mvllow/modes.nvim

local black = "#0d0f18"
local white = "#75869a"
local red = "#dd6777"
local dull = "#424b56"
local green = "#659239"
local float = "#0f191f" --"#181825" -- "#0f191f" --"#181820"
local greenLight = "#90ceaa"

---@type table<string, vim.api.keyset.highlight>
local groups = {
  Default = { fg = white },
  Normal = { bg = black, fg = white },
  Special = { fg = "#379c9b" },
  String = { fg = green },
  -- Operator = { fg = "#e6b99d" },
  Operator = { fg = "#ae8e57" },
  qfSeparator1 = { link = "Operator" },
  qfSeparator2 = { link = "qfSeparator1" },
  Type = { link = "Default" },
  Comment = { fg = dull, italic = true },
  Conceal = { fg = dull },
  Visual = { bg = "#1e293b" },
  CursorLine = { link = "Visual" },
  QuickFixLine = { link = "Visual" },
  qfFileName = { link = "@keyword" },
  qfLineNr = { link = "Operator" },
  qfText = { link = "Default" },
  -- Visual = { bg = "#292a2c" },
  Constant = { link = "String" },
  Function = { link = "Default" },
  Identifier = { link = "Default" },
  Error = { bg = "#3d0206", fg = white },
  ErrorMsg = { fg = red },
  DiagnosticError = { link = "ErrorMsg" },
  DiagnosticUnderlineError = { sp = "red", undercurl = true },
  DiagnosticUnderlineInfo = { sp = "NvimLightCyan", undercurl = true },
  DiagnosticUnderlineWarn = { sp = "NvimLightYellow", undercurl = true },
  DiagnosticUnderlineOk = { sp = "NvimLightGreen", undercurl = true },
  DiagnosticUnderlineHint = { sp = "NvimLightBlue", undercurl = true },
  NormalFloat = { bg = float },
  -- NormalFloat = { bg = "#202830" },
  StatusLine = { bg = float },
  Tabline = { link = "Visual" },
  WinSeparator = { fg = dull },
  Search = { bg = "#2a2827" },
  -- Search = { bg = "#2c2e33" },
  -- Search = { bg = "#202830" },
  CurSearch = { bg = white, fg = black },
  PMenu = { link = "NormalFloat" },
  -- PmenuSel = { bg = white, fg = black },
  PmenuSel = { link = "Visual" },
  CmpItemKind = { link = "Comment" },
  BlinkCmpKind = { link = "Comment" },
  BlinkCmpLabelMatch = { link = "@keyword" },
  MatchParen = { bg = "#4c5063", fg = "#FFFFFF" },
  GitSignsAdd = { fg = green },
  diffAdd = { bg = "#364937" },
  Added = { link = "String" },
  Removed = { fg = "#dd6777" },
  diffAdded = { link = "GitSignsAdd" },
  diffDelete = { bg = "#493636" },
  diffDeleted = { link = "GitSignsDelete" },
  GitSignsChange = { fg = "#946a37" },
  GitSignsDelete = { fg = red },
  FloatBorder = { fg = dull, bg = float },
  -- TelescopeNormal = { link = "NormalFloat" },
  -- TelescopeBorder = { link = "FloatBorder" },
  ["@constructor"] = { link = "Default" },
  ["@lsp.type.namespace.go"] = { link = "String" },
  ["@variable"] = { link = "Default" },
  -- ["@keyword"] = { fg = "#6699cc" },
  ["@keyword"] = { fg = "#6388c4" },
  ["@type"] = { fg = "#7b9695" },
  ["@type.builtin"] = { link = "@keyword" },
  ["@variable.builtin"] = { link = "@keyword" },
  ["@function.builtin"] = { link = "@keyword" },
  ["@constant.builtin"] = { link = "@keyword" },
  ["@punctuation"] = { link = "Operator" },
  SnacksPicker = { link = "Normal" },
  SnacksPickerBorder = { fg = dull },
  NormalNC = { link = "Normal" },

  fugitiveHeading = { link = "@keyword" },
  fugitiveUntrackedHeading = { link = "@keyword" },
  fugitiveStagedHeading = { link = "@keyword" },
  fugitiveUnstagedHeading = { link = "@keyword" },
}

vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd("hi clear")
vim.g.colors_name = "silence"
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
-- disable all semantic highlights by clearing all the groups
for _, group in ipairs(vim.fn.getcompletion("@lsp.", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

for group, hl in pairs(groups) do
  vim.api.nvim_set_hl(0, group, hl)
end
