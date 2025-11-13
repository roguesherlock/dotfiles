vim.cmd.highlight("clear")
vim.o.termguicolors = true
vim.g.colors_name = "plastic"

--
-- Plastic palette
--
-- {
--   bunker: '#0D1117',
--   cadetBlue: '#A9B2C3',
--   cornflowerBlue: '#61AFEF',
--   crail: '#BE5046',
--   dodgerBlue: '#1085FF',
--   fountainBlue: '#56B6C2',
--   ghost: '#C6CCD7',
--   harvestGold: '#E5C07B',
--   lavender: '#B57EDC',
--   olivine: '#98C379',
--   robRoy: '#E9D16C',
--   shark: '#21252B',
--   shuttleGray: '#5F6672',
--   sunglo: '#E06C75',
--   transparent: '#00000000',
--   valencia: '#D74E42',
--   whiskey: '#D19A66',
--   white: '#ffffff',
--   woodsmoke: '#181A1F',
-- }

local p = {}

-- Core colors
p.bunker = "#0D1117"
p.cadetBlue = "#A9B2C3"
p.cornflowerBlue = "#61AFEF"
p.crail = "#BE5046"
p.dodgerBlue = "#1085FF"
p.fountainBlue = "#56B6C2"
p.ghost = "#C6CCD7"
p.harvestGold = "#E5C07B"
p.lavender = "#B57EDC"
p.olivine = "#98C379"
p.robRoy = "#E9D16C"
p.shark = "#21252B"
p.shuttleGray = "#5F6672"
p.sunglo = "#E06C75"
p.transparent = "#00000000"
p.valencia = "#D74E42"
p.whiskey = "#D19A66"
p.white = "#ffffff"
p.woodsmoke = "#181A1F"

-- Additional shades for light theme (lightened versions)
p.lightBg = "#F5F5F5"
p.lightBg2 = "#E8E8E8"
p.lightUi = "#D0D0D0"
p.lightUi2 = "#BEBEBE"
p.lightUi3 = "#ACACAC"
p.lightTx = "#21252B"
p.lightTx2 = "#5F6672"
p.lightTx3 = "#A9B2C3"

--
-- Theme colors
--

local c = {}

if vim.o.background == "dark" then
  -- Dark theme
  -- UI colors
  c.bg = p.woodsmoke
  c.bg2 = p.shark
  c.ui = p.shark
  c.ui2 = p.bunker
  c.ui3 = p.shuttleGray

  -- Text colors
  c.tx = p.ghost -- Variables
  c.tx2 = p.cadetBlue -- Text & Punctuation
  c.tx3 = p.shuttleGray -- Comments

  -- Syntax colors
  c.keyword = p.sunglo -- Keywords (if, import, return)
  c.storage = p.cornflowerBlue -- Storage (const, let, class)
  c.constant = p.fountainBlue -- Constants (numbers, booleans)
  c.string = p.olivine -- String literals
  c.attribute = p.whiskey -- Attributes & Props
  c.type = p.harvestGold -- Tags & Types
  c.func = p.lavender -- Function names

  -- Diagnostic colors
  c.error = p.valencia
  c.warning = p.robRoy
  c.info = p.dodgerBlue
  c.hint = p.cadetBlue

  -- Git colors
  c.add = p.olivine
  c.change = p.harvestGold
  c.delete = p.sunglo
else
  -- Light theme (same syntax colors, adjusted UI)
  c.bg = p.lightBg
  c.bg2 = p.lightBg2
  c.ui = p.lightUi
  c.ui2 = p.lightUi2
  c.ui3 = p.lightUi3

  -- Text colors
  c.tx = p.lightTx
  c.tx2 = p.lightTx2
  c.tx3 = p.lightTx3

  -- Syntax colors (same as dark)
  c.keyword = p.sunglo
  c.storage = p.cornflowerBlue
  c.constant = p.fountainBlue
  c.string = p.olivine
  c.attribute = p.whiskey
  c.type = p.harvestGold
  c.func = p.lavender

  -- Diagnostic colors
  c.error = p.valencia
  c.warning = p.robRoy
  c.info = p.dodgerBlue
  c.hint = p.cadetBlue

  -- Git colors
  c.add = p.olivine
  c.change = p.harvestGold
  c.delete = p.sunglo
end

--
-- Highlights
--

local function hl(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

-- Editor highlights (:help highlight-groups)
hl("ColorColumn", { bg = c.bg2 })
hl("Conceal", { fg = c.tx3 })
hl("CurSearch", { bg = c.orange3 })
hl("Cursor", { fg = c.bg, bg = c.tx })
hl("lCursor", { link = "Cursor" })
hl("CursorIM", { link = "Cursor" })
hl("CursorColumn", { link = "CursorLine" })
hl("CursorLine", { bg = c.bg2 })
hl("Directory", { fg = c.storage })
hl("DiffAdd", { fg = c.add, bg = c.bg2 })
hl("DiffChange", { fg = c.change, bg = c.bg2 })
hl("DiffDelete", { fg = c.delete, bg = c.bg2 })
hl("DiffText", { bg = c.bg2, bold = true })
hl("EndOfBuffer", { link = "NonText" })
hl("TermCursor", { link = "Cursor" })
hl("ErrorMsg", { fg = c.error })
hl("WinSeparator", { fg = c.ui2 })
hl("Folded", { fg = c.tx3, bg = c.bg2 })
hl("FoldColumn", { link = "SignColumn" })
hl("SignColumn", { fg = c.tx3 })
hl("IncSearch", { link = "CurSearch" })
hl("Substitute", { link = "Search" })
hl("LineNr", { fg = c.tx3 })
hl("LineNrAbove", { link = "LineNr" })
hl("LineNrBelow", { link = "LineNr" })
hl("CursorLineNr", { fg = c.tx2 })
hl("CursorLineFold", { link = "CursorLineSign" })
hl("CursorLineSign", { fg = c.tx3, bg = c.bg2 })
hl("MatchParen", { fg = c.constant, bold = true })
hl("ModeMsg", { fg = c.tx2 })
hl("MsgArea", {})
hl("MsgSeparator", { link = "StatusLine" })
hl("MoreMsg", { link = "Normal" })
hl("NonText", { fg = c.tx3 })
hl("Normal", { fg = c.tx, bg = c.bg })
hl("NormalFloat", { bg = c.bg2 })
hl("FloatBorder", { fg = c.ui2, bg = c.bg2 })
hl("FloatTitle", { fg = c.tx, bg = c.bg2, bold = true })
hl("FloatFooter", { link = "NormalFloat" })
hl("NormalNC", { link = "Normal" })
hl("Pmenu", { fg = c.tx2, bg = c.bg2 })
hl("PmenuSel", { fg = c.tx, bg = c.ui })
hl("PmenuKind", { link = "Pmenu" })
hl("PmenuKindSel", { link = "PmenuSel" })
hl("PmenuExtra", { link = "Pmenu" })
hl("PmenuExtraSel", { link = "PmenuSel" })
hl("PmenuSbar", { link = "Pmenu" })
hl("PmenuThumb", { bg = c.tx3 })
hl("PmenuMatch", { fg = c.info, bold = true })
hl("PmenuMatchSelect", { link = "PmenuMatch" })
hl("ComplMatchIns", {})
hl("Question", { fg = c.info })
hl("QuickFixLine", { fg = c.constant })
hl("Search", { bg = c.ui, fg = c.type })
hl("SnippetTabstop", { link = "Visual" })
hl("SpecialKey", { fg = c.tx3 })
hl("SpellBad", { sp = c.error, undercurl = true })
hl("SpellCap", { sp = c.warning, undercurl = true })
hl("SpellLocal", { sp = c.constant, undercurl = true })
hl("SpellRare", { sp = c.func, undercurl = true })
hl("StatusLine", { bg = c.ui })
hl("StatusLineNC", { fg = c.tx3, bg = c.bg2 })
hl("StatusLineTerm", { link = "StatusLine" })
hl("StatusLineTermNC", { link = "StatusLineNC" })
hl("TabLine", { link = "StatusLineNC" })
hl("TabLineFill", { link = "TabLine" })
hl("TabLineSel", { fg = c.tx, bold = true })
hl("Title", { fg = c.type, bold = true })
hl("Visual", { bg = c.ui })
hl("VisualNOS", { link = "Visual" })
hl("WarningMsg", { fg = c.warning })
hl("Whitespace", { link = "NonText" })
hl("WildMenu", { link = "PmenuSel" })
hl("WinBar", { link = "StatusLine" })
hl("WinBarNC", { link = "StatusLineNC" })

-- Syntax highlights (:help group-name)
hl("Comment", { fg = c.tx3 })
hl("Constant", { fg = c.constant })
hl("String", { fg = c.string })
hl("Character", { fg = c.string })
hl("Number", { fg = c.constant })
hl("Boolean", { fg = c.constant })
hl("Float", { link = "Number" })

hl("Identifier", { fg = c.tx })
hl("Function", { fg = c.func })

hl("Statement", { link = "Keyword" })
hl("Conditional", { link = "Keyword" })
hl("Repeat", { link = "Keyword" })
hl("Label", { link = "Keyword" })
hl("Operator", { fg = c.tx2 })
hl("Keyword", { fg = c.keyword })
hl("Exception", { link = "Keyword" })

hl("PreProc", { fg = c.keyword })
hl("Include", { fg = c.keyword })
hl("Define", { link = "PreProc" })
hl("Macro", { fg = c.func })
hl("PreCondit", { link = "PreProc" })

hl("Type", { fg = c.type })
hl("StorageClass", { fg = c.storage })
hl("Structure", { fg = c.storage })
hl("Typedef", { link = "Type" })

hl("Special", { fg = c.attribute })
hl("SpecialChar", { link = "Special" })
hl("Tag", { fg = c.type })
hl("Delimiter", { fg = c.tx2 })
hl("SpecialComment", { link = "Special" })
hl("Debug", { link = "Special" })

hl("Underlined", { underline = true })
hl("Ignore", { fg = c.tx3 })
hl("Error", { fg = c.error })
hl("Todo", { fg = c.info, bold = true })

hl("Added", { fg = c.add })
hl("Changed", { fg = c.change })
hl("Removed", { fg = c.delete })

-- Diagnostic highlights (:help diagnostic-highlights)
hl("DiagnosticError", { fg = c.error })
hl("DiagnosticWarn", { fg = c.warning })
hl("DiagnosticInfo", { fg = c.info })
hl("DiagnosticHint", { fg = c.hint })
hl("DiagnosticOk", { fg = c.add })

hl("DiagnosticVirtualTextError", { link = "DiagnosticError" })
hl("DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
hl("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
hl("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
hl("DiagnosticVirtualTextOk", { link = "DiagnosticOk" })

hl("DiagnosticUnderlineError", { sp = c.error, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = c.warning, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = c.info, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = c.hint, undercurl = true })
hl("DiagnosticUnderlineOk", { sp = c.add, undercurl = true })

hl("DiagnosticFloatingError", { link = "DiagnosticError" })
hl("DiagnosticFloatingWarn", { link = "DiagnosticWarn" })
hl("DiagnosticFloatingInfo", { link = "DiagnosticInfo" })
hl("DiagnosticFloatingHint", { link = "DiagnosticHint" })
hl("DiagnosticFloatingOk", { link = "DiagnosticOk" })

hl("DiagnosticSignError", { link = "DiagnosticError" })
hl("DiagnosticSignWarn", { link = "DiagnosticWarn" })
hl("DiagnosticSignInfo", { link = "DiagnosticInfo" })
hl("DiagnosticSignHint", { link = "DiagnosticHint" })
hl("DiagnosticSignOk", { link = "DiagnosticOk" })

hl("DiagnosticDeprecated", { sp = c.error, strikethrough = true })
hl("DiagnosticUnnecessary", { link = "Comment" })

-- Treesitter highlights (:help treesitter-highlight-groups)
hl("@variable", { fg = c.tx })
hl("@variable.builtin", { fg = c.constant })
hl("@variable.parameter", { fg = c.tx })
hl("@variable.parameter.builtin", { fg = c.constant })
hl("@variable.member", { fg = c.attribute })

hl("@constant", { link = "Constant" })
hl("@constant.builtin", { fg = c.constant })
hl("@constant.macro", { fg = c.constant })

hl("@module", { fg = c.tx })
hl("@module.builtin", { fg = c.constant })
hl("@label", { fg = c.keyword })

hl("@string", { link = "String" })
hl("@string.documentation", { link = "String" })
hl("@string.regexp", { fg = c.string })
hl("@string.escape", { fg = c.constant })
hl("@string.special", { link = "String" })
hl("@string.special.symbol", { fg = c.tx })
hl("@string.special.path", { link = "String" })
hl("@string.special.url", { fg = c.constant, underline = true })

hl("@character", { link = "Character" })
hl("@character.special", { link = "String" })

hl("@boolean", { link = "Boolean" })
hl("@number", { link = "Number" })
hl("@float", { link = "Float" })

hl("@type", { link = "Type" })
hl("@type.builtin", { fg = c.type })
hl("@type.definition", { link = "Type" })

hl("@attribute", { fg = c.attribute })
hl("@attribute.builtin", { fg = c.attribute })
hl("@property", { fg = c.attribute })

hl("@function", { link = "Function" })
hl("@function.builtin", { fg = c.func })
hl("@function.call", { link = "Function" })
hl("@function.macro", { fg = c.func })

hl("@function.method", { link = "Function" })
hl("@function.method.call", { link = "Function" })

hl("@constructor", { fg = c.type })
hl("@operator", { link = "Operator" })

hl("@keyword", { link = "Keyword" })
hl("@keyword.coroutine", { link = "Keyword" })
hl("@keyword.function", { link = "Keyword" })
hl("@keyword.operator", { link = "Keyword" })
hl("@keyword.import", { link = "Keyword" })
hl("@keyword.type", { fg = c.storage })
hl("@keyword.modifier", { fg = c.storage })
hl("@keyword.repeat", { link = "Keyword" })
hl("@keyword.return", { link = "Keyword" })
hl("@keyword.debug", { link = "Keyword" })
hl("@keyword.exception", { link = "Keyword" })

hl("@keyword.conditional", { link = "Keyword" })
hl("@keyword.conditional.ternary", { link = "Keyword" })

hl("@keyword.directive", { link = "Keyword" })
hl("@keyword.directive.define", { link = "Keyword" })

hl("@punctuation.delimiter", { fg = c.tx2 })
hl("@punctuation.bracket", { fg = c.tx2 })
hl("@punctuation.special", { fg = c.tx2 })

hl("@comment", { link = "Comment" })
hl("@comment.documentation", { link = "Comment" })

hl("@comment.error", { link = "DiagnosticError" })
hl("@comment.warning", { link = "DiagnosticWarn" })
hl("@comment.todo", { link = "Todo" })
hl("@comment.note", { link = "DiagnosticInfo" })

hl("@markup.strong", { bold = true })
hl("@markup.italic", { italic = true })
hl("@markup.strikethrough", { strikethrough = true })
hl("@markup.underline", { underline = true })

hl("@markup.heading", { link = "Title" })
hl("@markup.heading.1", { link = "Title" })
hl("@markup.heading.2", { link = "Title" })
hl("@markup.heading.3", { link = "Title" })
hl("@markup.heading.4", { link = "Title" })
hl("@markup.heading.5", { link = "Title" })
hl("@markup.heading.6", { link = "Title" })

hl("@markup.quote", { italic = true })
hl("@markup.math", { fg = c.constant })

hl("@markup.link", { fg = c.constant, underline = true })
hl("@markup.link.label", { link = "@markup.link" })
hl("@markup.link.url", { link = "@markup.link" })

hl("@markup.raw", { fg = c.string, bg = c.bg2 })
hl("@markup.raw.block", { link = "@markup.raw" })

hl("@markup.list", { fg = c.tx2 })
hl("@markup.list.checked", { fg = c.add, bg = c.bg2 })
hl("@markup.list.unchecked", { fg = c.tx2, bg = c.bg2 })

hl("@diff.plus", { link = "Added" })
hl("@diff.minus", { link = "Removed" })
hl("@diff.delta", { link = "Changed" })

hl("@tag", { fg = c.type })
hl("@tag.builtin", { link = "@tag" })
hl("@tag.attribute", { fg = c.attribute })
hl("@tag.delimiter", { fg = c.tx2 })

-- LSP semantic token highlights
hl("@lsp.type.comment", { link = "@comment" })
hl("@lsp.type.enum", { link = "@type" })
hl("@lsp.type.enumMember", { link = "@constant" })
hl("@lsp.type.interface", { fg = c.type })
hl("@lsp.type.keyword", { link = "@keyword" })
hl("@lsp.type.namespace", { link = "@module" })
hl("@lsp.type.parameter", { link = "@variable.parameter" })
hl("@lsp.type.property", { link = "@property" })
hl("@lsp.type.variable", { link = "@variable" })
hl("@lsp.type.macro", { fg = c.func })
hl("@lsp.type.method", { link = "@function.method" })
hl("@lsp.type.number", { link = "@number" })
hl("@lsp.type.operator", { link = "@operator" })
hl("@lsp.type.string", { link = "@string" })
hl("@lsp.type.struct", { link = "@type" })
hl("@lsp.type.type", { link = "@type" })
hl("@lsp.type.typeParameter", { link = "@type.definition" })
hl("@lsp.type.decorator", { link = "@attribute" })
hl("@lsp.type.builtinType", { link = "@type.builtin" })
hl("@lsp.type.function", { link = "@function" })
hl("@lsp.type.class", { link = "@type" })

-- Custom statusline highlights
hl("StatusLineModeN", { fg = c.storage })
hl("StatusLineModeI", { fg = c.string })
hl("StatusLineModeV", { fg = c.func })
hl("StatusLineModeR", { fg = c.delete })
hl("StatusLineModeC", { fg = c.warning })
hl("StatusLineModeT", { fg = c.constant })

-- gitsigns.nvim highlights (:help gitsigns-highlight-groups)
hl("GitSignsAdd", { fg = c.add })
hl("GitSignsChange", { fg = c.change })
hl("GitSignsDelete", { fg = c.delete })
hl("GitSignsDeleteLn", { link = "DiffDelete" })
hl("GitSignsStagedAdd", { fg = c.add })
hl("GitSignsStagedChange", { fg = c.change })
hl("GitSignsStagedDelete", { fg = c.delete })
hl("GitSignsStagedChangedelete", { link = "GitSignsStagedChange" })
hl("GitSignsStagedTopdelete", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedUntracked", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedAddNr", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedChangeNr", { link = "GitSignsStagedChange" })
hl("GitSignsStagedDeleteNr", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedChangedeleteNr", { link = "GitSignsStagedChange" })
hl("GitSignsStagedTopdeleteNr", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedUntrackedNr", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedAddLn", { fg = c.add, bg = c.bg2 })
hl("GitSignsStagedChangeLn", { fg = c.change, bg = c.bg2 })
hl("GitSignsStagedDeleteLn", { fg = c.delete, bg = c.bg2 })
hl("GitSignsStagedChangedeleteLn", { link = "GitSignsStagedChangeLn" })
hl("GitSignsStagedTopdeleteLn", { link = "GitSignsStagedDeleteLn" })
hl("GitSignsStagedUntrackedLn", { link = "GitSignsStagedAddLn" })
hl("GitSignsStagedAddCul", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedChangeCul", { link = "GitSignsStagedChange" })
hl("GitSignsStagedDeleteCul", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedChangedeleteCul", { link = "GitSignsStagedChange" })
hl("GitSignsStagedTopdeleteCul", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedUntrackedCul", { link = "GitSignsStagedAdd" })

hl("SnacksIndent", { fg = c.bg2 })
hl("BlinkIndent", { fg = c.bg2 })

--
-- Terminal colors (ANSI)
--

if vim.o.background == "dark" then
  vim.g.terminal_color_0 = p.shuttleGray -- Black
  vim.g.terminal_color_1 = p.sunglo -- Red
  vim.g.terminal_color_2 = p.olivine -- Green
  vim.g.terminal_color_3 = p.harvestGold -- Yellow
  vim.g.terminal_color_4 = p.cornflowerBlue -- Blue
  vim.g.terminal_color_5 = p.lavender -- Magenta
  vim.g.terminal_color_6 = p.fountainBlue -- Cyan
  vim.g.terminal_color_7 = p.cadetBlue -- White

  -- Bright colors (same as normal per Plastic spec)
  vim.g.terminal_color_8 = p.shuttleGray -- Bright Black
  vim.g.terminal_color_9 = p.sunglo -- Bright Red
  vim.g.terminal_color_10 = p.olivine -- Bright Green
  vim.g.terminal_color_11 = p.harvestGold -- Bright Yellow
  vim.g.terminal_color_12 = p.cornflowerBlue -- Bright Blue
  vim.g.terminal_color_13 = p.lavender -- Bright Magenta
  vim.g.terminal_color_14 = p.fountainBlue -- Bright Cyan
  vim.g.terminal_color_15 = p.ghost -- Bright White
else
  -- Light theme terminal colors
  vim.g.terminal_color_0 = p.shuttleGray
  vim.g.terminal_color_1 = p.sunglo
  vim.g.terminal_color_2 = p.olivine
  vim.g.terminal_color_3 = p.harvestGold
  vim.g.terminal_color_4 = p.cornflowerBlue
  vim.g.terminal_color_5 = p.lavender
  vim.g.terminal_color_6 = p.fountainBlue
  vim.g.terminal_color_7 = p.cadetBlue

  vim.g.terminal_color_8 = p.shuttleGray
  vim.g.terminal_color_9 = p.sunglo
  vim.g.terminal_color_10 = p.olivine
  vim.g.terminal_color_11 = p.harvestGold
  vim.g.terminal_color_12 = p.cornflowerBlue
  vim.g.terminal_color_13 = p.lavender
  vim.g.terminal_color_14 = p.fountainBlue
  vim.g.terminal_color_15 = p.lightTx
end
