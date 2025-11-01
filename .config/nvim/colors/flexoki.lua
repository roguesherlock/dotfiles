vim.cmd.highlight("clear")
vim.o.termguicolors = true
vim.g.colors_name = "flexoki"

--
-- Flexoki palette
--

local p = {}

-- Base
p.black = "#100F0F"
p.base950 = "#1C1B1A"
p.base900 = "#282726"
p.base850 = "#343331"
p.base800 = "#403E3C"
p.base700 = "#575653"
p.base600 = "#6F6E69"
p.base500 = "#878580"
p.base400 = "#9F9D96"
p.base300 = "#B7B5AC"
p.base200 = "#CECDC3"
p.base150 = "#DAD8CE"
p.base100 = "#E6E4D9"
p.base50 = "#F2F0E5"
p.paper = "#FFFCF0"

-- Red
p.red950 = "#261312"
p.red900 = "#3E1715"
p.red850 = "#551B18"
p.red800 = "#6C201C"
p.red700 = "#942822"
p.red600 = "#AF3029"
p.red500 = "#C03E35"
p.red400 = "#D14D41"
p.red300 = "#E8705F"
p.red200 = "#F89A8A"
p.red150 = "#FDB2A2"
p.red100 = "#FFCABB"
p.red50 = "#FFE1D5"

-- Orange
p.orange950 = "#27180E"
p.orange900 = "#40200D"
p.orange850 = "#59290D"
p.orange800 = "#71320D"
p.orange700 = "#9D4310"
p.orange600 = "#BC5215"
p.orange500 = "#CB6120"
p.orange400 = "#DA702C"
p.orange300 = "#EC8B49"
p.orange200 = "#F9AE77"
p.orange150 = "#FCC192"
p.orange100 = "#FED3AF"
p.orange50 = "#FFE7CE"

-- Yellow
p.yellow950 = "#241E08"
p.yellow900 = "#3A2D04"
p.yellow850 = "#503D02"
p.yellow800 = "#664D01"
p.yellow700 = "#8E6B01"
p.yellow600 = "#AD8301"
p.yellow500 = "#BE9207"
p.yellow400 = "#D0A215"
p.yellow300 = "#DFB431"
p.yellow200 = "#ECCB60"
p.yellow150 = "#F1D67E"
p.yellow100 = "#F6E2A0"
p.yellow50 = "#FAEEC6"

-- Green
p.green950 = "#1A1E0C"
p.green900 = "#252D09"
p.green850 = "#313D07"
p.green800 = "#3D4C07"
p.green700 = "#536907"
p.green600 = "#66800B"
p.green500 = "#768D21"
p.green400 = "#879A39"
p.green300 = "#A0AF54"
p.green200 = "#BEC97E"
p.green150 = "#CDD597"
p.green100 = "#DDE2B2"
p.green50 = "#EDEECF"

-- Cyan
p.cyan950 = "#101F1D"
p.cyan900 = "#122F2C"
p.cyan850 = "#143F3C"
p.cyan800 = "#164F4A"
p.cyan700 = "#1C6C66"
p.cyan600 = "#24837B"
p.cyan500 = "#2F968D"
p.cyan400 = "#3AA99F"
p.cyan300 = "#5ABDAC"
p.cyan200 = "#87D3C3"
p.cyan150 = "#A2DECE"
p.cyan100 = "#BFE8D9"
p.cyan50 = "#DDF1E4"

-- Blue
p.blue950 = "#101A24"
p.blue900 = "#12253B"
p.blue850 = "#133051"
p.blue800 = "#163B66"
p.blue700 = "#1A4F8C"
p.blue600 = "#205EA6"
p.blue500 = "#3171B2"
p.blue400 = "#4385BE"
p.blue300 = "#66A0C8"
p.blue200 = "#92BFDB"
p.blue150 = "#ABCFE2"
p.blue100 = "#C6DDE8"
p.blue50 = "#E1ECEB"

-- Purple
p.purple950 = "#1A1623"
p.purple900 = "#261C39"
p.purple850 = "#31234E"
p.purple800 = "#3C2A62"
p.purple700 = "#4F3685"
p.purple600 = "#5E409D"
p.purple500 = "#735EB5"
p.purple400 = "#8B7EC8"
p.purple300 = "#A699D0"
p.purple200 = "#C4B9E0"
p.purple150 = "#D3CAE6"
p.purple100 = "#E2D9E9"
p.purple50 = "#F0EAEC"

-- Magenta
p.magenta950 = "#24131D"
p.magenta900 = "#39172B"
p.magenta850 = "#4F1B39"
p.magenta800 = "#641F46"
p.magenta700 = "#87285E"
p.magenta600 = "#A02F6F"
p.magenta500 = "#B74583"
p.magenta400 = "#CE5D97"
p.magenta300 = "#E47DA8"
p.magenta200 = "#F4A4C2"
p.magenta150 = "#F9B9CF"
p.magenta100 = "#FCCFDA"
p.magenta50 = "#FEE4E5"

--
-- Theme colors
--

local c = {}

if vim.o.background == "dark" then
  -- Dark theme
  c.bg = p.black
  c.bg2 = p.base950
  c.ui = p.base900
  c.ui2 = p.base850
  c.ui3 = p.base800
  c.tx = p.base200
  c.tx2 = p.base400
  c.tx3 = p.base600
  c.red = p.red400
  c.red2 = p.red600
  c.red3 = p.red800
  c.red4 = p.red900
  c.orange = p.orange400
  c.orange2 = p.orange600
  c.orange3 = p.orange800
  c.orange4 = p.orange900
  c.yellow = p.yellow400
  c.yellow2 = p.yellow600
  c.yellow3 = p.yellow800
  c.yellow4 = p.yellow900
  c.green = p.green400
  c.green2 = p.green600
  c.green3 = p.green800
  c.green4 = p.green900
  c.cyan = p.cyan400
  c.cyan2 = p.cyan600
  c.cyan3 = p.cyan800
  c.cyan4 = p.cyan900
  c.blue = p.blue400
  c.blue2 = p.blue600
  c.blue3 = p.blue800
  c.blue4 = p.blue900
  c.purple = p.purple400
  c.purple2 = p.purple600
  c.purple3 = p.purple800
  c.purple4 = p.purple900
  c.magenta = p.magenta400
  c.magenta2 = p.magenta600
  c.magenta3 = p.magenta800
  c.magenta4 = p.magenta900
else
  -- Light theme
  c.bg = p.paper
  c.bg2 = p.base50
  c.ui = p.base100
  c.ui2 = p.base150
  c.ui3 = p.base200
  c.tx = p.base800
  c.tx2 = p.base600
  c.tx3 = p.base400
  c.red = p.red600
  c.red2 = p.red400
  c.red3 = p.red200
  c.red4 = p.red100
  c.orange = p.orange600
  c.orange2 = p.orange400
  c.orange3 = p.orange200
  c.orange4 = p.orange100
  c.yellow = p.yellow600
  c.yellow2 = p.yellow400
  c.yellow3 = p.yellow200
  c.yellow4 = p.yellow100
  c.green = p.green600
  c.green2 = p.green400
  c.green3 = p.green200
  c.green4 = p.green100
  c.cyan = p.cyan600
  c.cyan2 = p.cyan400
  c.cyan3 = p.cyan200
  c.cyan4 = p.cyan100
  c.blue = p.blue600
  c.blue2 = p.blue400
  c.blue3 = p.blue200
  c.blue4 = p.blue100
  c.purple = p.purple600
  c.purple2 = p.purple400
  c.purple3 = p.purple200
  c.purple4 = p.purple100
  c.magenta = p.magenta600
  c.magenta2 = p.magenta400
  c.magenta3 = p.magenta200
  c.magenta4 = p.magenta100
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
hl("Directory", { fg = c.blue })
hl("DiffAdd", { fg = c.green, bg = c.green4 })
hl("DiffChange", { fg = c.yellow, bg = c.yellow4 })
hl("DiffDelete", { fg = c.red, bg = c.red4 })
hl("DiffText", { bg = c.yellow3 })
hl("EndOfBuffer", { link = "NonText" })
hl("TermCursor", { link = "Cursor" })
hl("ErrorMsg", { fg = c.red })
hl("WinSeparator", { fg = c.ui })
hl("Folded", { fg = c.tx3, bg = c.bg2 })
hl("FoldColumn", { link = "SignColumn" })
hl("SignColumn", { fg = c.tx3 })
hl("IncSearch", { link = "CurSearch" })
hl("Substitute", { link = "Search" })
hl("LineNr", { fg = c.tx3 })
hl("LineNrAbove", { link = "LineNr" })
hl("LineNrBelow", { link = "LineNr" })
hl("CursorLineNr", { link = "CursorLine" })
hl("CursorLineFold", { link = "CursorLineSign" })
hl("CursorLineSign", { fg = c.tx3, bg = c.bg2 })
hl("MatchParen", { fg = c.tx2, bold = true })
hl("ModeMsg", { fg = c.tx2 })
hl("MsgArea", {})
hl("MsgSeparator", { link = "StatusLine" })
hl("MoreMsg", { link = "Normal" })
hl("NonText", { fg = c.tx3 })
hl("Normal", { fg = c.tx, bg = c.bg })
hl("NormalFloat", { bg = c.bg2 })
hl("FloatBorder", { link = "NormalFloat" })
hl("FloatTitle", { bg = c.bg2, bold = true })
hl("FloatFooter", { link = "NormalFloat" })
hl("NormalNC", {})
hl("Pmenu", { fg = c.tx2, bg = c.bg2 })
hl("PmenuSel", { bg = c.blue4 })
hl("PmenuKind", { link = "Pmenu" })
hl("PmenuKindSel", { link = "PmenuSel" })
hl("PmenuExtra", { link = "Pmenu" })
hl("PmenuExtraSel", { link = "PmenuSel" })
hl("PmenuSbar", { link = "Pmenu" })
hl("PmenuThumb", { bg = c.tx3 })
hl("PmenuMatch", { fg = c.tx2, bold = true })
hl("PmenuMatchSelect", { link = "PmenuMatch" })
hl("ComplMatchIns", {})
hl("Question", { fg = c.blue })
hl("QuickFixLine", { fg = c.cyan })
hl("Search", { bg = c.yellow3 })
hl("SnippetTabstop", { link = "Visual" })
hl("SpecialKey", { fg = c.tx3 })
hl("SpellBad", { sp = c.red, undercurl = true })
hl("SpellCap", { sp = c.yellow, undercurl = true })
hl("SpellLocal", { sp = c.cyan, undercurl = true })
hl("SpellRare", { sp = c.purple, undercurl = true })
hl("StatusLine", { bg = c.ui })
hl("StatusLineNC", { fg = c.tx3, bg = c.bg2 })
hl("StatusLineTerm", { link = "StatusLine" })
hl("StatusLineTermNC", { link = "StatusLineNC" })
hl("TabLine", { link = "StatusLineNC" })
hl("TabLineFill", { link = "TabLine" })
hl("TabLineSel", { bold = true })
hl("Title", { bold = true })
hl("Visual", { bg = c.blue4 })
hl("VisualNOS", { link = "Visual" })
hl("WarningMsg", { fg = c.orange })
hl("Whitespace", { link = "NonText" })
hl("WildMenu", { link = "PmenuSel" })
hl("WinBar", { link = "StatusLine" })
hl("WinBarNC", { link = "StatusLineNC" })

-- Syntax highlights (:help group-name)
hl("Comment", { fg = c.tx3 })
hl("Constant", { fg = c.yellow })
hl("String", { fg = c.green })
hl("Character", { fg = c.orange })
hl("Number", { fg = c.orange })
hl("Boolean", { fg = c.orange })
hl("Float", { link = "Number" })

hl("Identifier", { fg = c.tx })
hl("Function", { fg = c.blue })

hl("Statement", { link = "Keyword" })
hl("Conditional", { link = "Keyword" })
hl("Repeat", { link = "Keyword" })
hl("Label", { link = "Keyword" })
hl("Operator", { fg = c.tx })
hl("Keyword", { fg = c.magenta })
hl("Exception", { link = "Keyword" })

hl("PreProc", { fg = c.orange })
hl("Include", { fg = c.cyan })
hl("Define", { link = "PreProc" })
hl("Macro", { fg = c.purple })
hl("PreCondit", { link = "PreProc" })

hl("Type", { fg = c.cyan })
hl("StorageClass", { link = "Type" })
hl("Structure", { link = "Type" })
hl("Typedef", { link = "Type" })

hl("Special", { fg = c.orange })
hl("SpecialChar", { link = "Special" })
hl("Tag", { link = "Special" })
hl("Delimiter", { link = "Special" })
hl("SpecialComment", { link = "Special" })
hl("Debug", { link = "Special" })

hl("Underlined", { underline = true })
hl("Ignore", { fg = c.tx3 })
hl("Error", { fg = c.red })
hl("Todo", { fg = c.cyan, bold = true })

hl("Added", { fg = c.green })
hl("Changed", { fg = c.yellow })
hl("Removed", { fg = c.red })

-- Diagnostic highlights (:help diagnostic-highlights)
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.orange })
hl("DiagnosticInfo", { fg = c.blue })
hl("DiagnosticHint", { fg = c.tx2 })
hl("DiagnosticOk", { fg = c.green })

hl("DiagnosticVirtualTextError", { link = "DiagnosticError" })
hl("DiagnosticVirtualTextWarn", { link = "DiagnosticWarn" })
hl("DiagnosticVirtualTextInfo", { link = "DiagnosticInfo" })
hl("DiagnosticVirtualTextHint", { link = "DiagnosticHint" })
hl("DiagnosticVirtualTextOk", { link = "DiagnosticOk" })

hl("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = c.orange, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = c.blue, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = c.tx2, undercurl = true })
hl("DiagnosticUnderlineOk", { sp = c.green, undercurl = true })

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

hl("DiagnosticDeprecated", { sp = c.red, strikethrough = true })
hl("DiagnosticUnnecessary", { link = "Comment" })

-- Treesitter highlights (:help treesitter-highlight-groups)
hl("@variable", { fg = c.tx })
hl("@variable.builtin", { fg = c.magenta })
hl("@variable.parameter", { fg = c.tx2 })
hl("@variable.parameter.builtin", { fg = c.magenta })
hl("@variable.member", { fg = c.tx })

hl("@constant", { link = "Constant" })
hl("@constant.builtin", { fg = c.orange })
hl("@constant.macro", { link = "PreProc" })

hl("@module", { link = "Structure" })
hl("@module.builtin", { link = "Special" })
hl("@label", { link = "Label" })

hl("@string", { link = "String" })
hl("@string.documentation", { link = "String" })
hl("@string.regexp", { link = "Special" })
hl("@string.escape", { fg = c.purple })
hl("@string.special", { link = "SpecialChar" })
hl("@string.special.symbol", { link = "Special" })
hl("@string.special.path", { link = "Special" })
hl("@string.special.url", { link = "Underlined" })

hl("@character", { link = "Character" })
hl("@character.special", { link = "Special" })

hl("@boolean", { link = "Boolean" })
hl("@number", { link = "Number" })
hl("@float", { link = "Float" })

hl("@type", { link = "Type" })
hl("@type.builtin", { link = "Special" })
hl("@type.definition", { link = "Type" })

hl("@attribute", { fg = c.tx2 })
hl("@attribute.builtin", { link = "Special" })
hl("@property", { fg = c.tx })

hl("@function", { link = "Function" })
hl("@function.builtin", { fg = c.purple })
hl("@function.call", { link = "Function" })
hl("@function.macro", { fg = c.purple })

hl("@function.method", { link = "Function" })
hl("@function.method.call", { link = "Function" })

hl("@constructor", { link = "Special" })
hl("@operator", { link = "Operator" })

hl("@keyword", { link = "Keyword" })
hl("@keyword.coroutine", { link = "Keyword" })
hl("@keyword.function", { link = "Keyword" })
hl("@keyword.operator", { link = "Keyword" })
hl("@keyword.import", { fg = c.cyan })
hl("@keyword.type", { link = "Type" })
hl("@keyword.modifier", { link = "Keyword" })
hl("@keyword.repeat", { link = "Repeat" })
hl("@keyword.return", { link = "Keyword" })
hl("@keyword.debug", { link = "Debug" })
hl("@keyword.exception", { link = "Exception" })

hl("@keyword.conditional", { link = "Conditional" })
hl("@keyword.conditional.ternary", { link = "Conditional" })

hl("@keyword.directive", { link = "PreProc" })
hl("@keyword.directive.define", { link = "PreProc" })

hl("@punctuation.delimiter", { fg = c.tx2 })
hl("@punctuation.bracket", { fg = c.tx2 })
hl("@punctuation.special", { link = "Special" })

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
hl("@markup.math", { link = "Special" })

hl("@markup.link", { fg = c.cyan, underline = true })
hl("@markup.link.label", { link = "@markup.link" })
hl("@markup.link.url", { link = "@markup.link" })

hl("@markup.raw", { bg = c.bg2 })
hl("@markup.raw.block", { link = "@markup.raw" })

hl("@markup.list", { fg = c.tx2 })
hl("@markup.list.checked", { fg = c.green, bg = c.green4 })
hl("@markup.list.unchecked", { fg = c.tx2, bg = c.bg2 })

hl("@diff.plus", { link = "Added" })
hl("@diff.minus", { link = "Removed" })
hl("@diff.delta", { link = "Changed" })

hl("@tag", { fg = c.blue })
hl("@tag.builtin", { link = "@tag" })
hl("@tag.attribute", { fg = c.tx2 })
hl("@tag.delimiter", { fg = c.tx2 })

-- LSP semantic token highlights
hl("@lsp.type.comment", { link = "@comment" })
hl("@lsp.type.enum", { link = "@type" })
hl("@lsp.type.enumMember", { link = "@constant" })
hl("@lsp.type.interface", { fg = c.cyan })
hl("@lsp.type.keyword", { link = "@keyword" })
hl("@lsp.type.namespace", { link = "@module" })
hl("@lsp.type.parameter", { link = "@variable.parameter" })
hl("@lsp.type.property", { link = "@property" })
hl("@lsp.type.variable", { link = "@variable" })
hl("@lsp.type.macro", { fg = c.purple })
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
hl("StatusLineModeN", { fg = c.blue })
hl("StatusLineModeI", { fg = c.green })
hl("StatusLineModeV", { fg = c.magenta })
hl("StatusLineModeR", { fg = c.red })
hl("StatusLineModeC", { fg = c.orange })
hl("StatusLineModeT", { fg = c.green })

-- gitsigns.nvim highlights (:help gitsigns-highlight-groups)
hl("GitSignsDeleteLn", { link = "DiffDelete" })
hl("GitSignsStagedAdd", { fg = c.green3 })
hl("GitSignsStagedChange", { fg = c.yellow3 })
hl("GitSignsStagedDelete", { fg = c.red3 })
hl("GitSignsStagedChangedelete", { link = "GitSignsStagedChange" })
hl("GitSignsStagedTopdelete", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedUntracked", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedAddNr", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedChangeNr", { link = "GitSignsStagedChange" })
hl("GitSignsStagedDeleteNr", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedChangedeleteNr", { link = "GitSignsStagedChange" })
hl("GitSignsStagedTopdeleteNr", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedUntrackedNr", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedAddLn", { fg = c.green3, bg = c.green4 })
hl("GitSignsStagedChangeLn", { fg = c.yellow3, bg = c.yellow4 })
hl("GitSignsStagedDeleteLn", { fg = c.red3, bg = c.red4 })
hl("GitSignsStagedChangedeleteLn", { link = "GitSignsStagedChangeLn" })
hl("GitSignsStagedTopdeleteLn", { link = "GitSignsStagedDeleteLn" })
hl("GitSignsStagedUntrackedLn", { link = "GitSignsStagedAddLn" })
hl("GitSignsStagedAddCul", { link = "GitSignsStagedAdd" })
hl("GitSignsStagedChangeCul", { link = "GitSignsStagedChange" })
hl("GitSignsStagedDeleteCul", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedChangedeleteCul", { link = "GitSignsStagedChange" })
hl("GitSignsStagedTopdeleteCul", { link = "GitSignsStagedDelete" })
hl("GitSignsStagedUntrackedCul", { link = "GitSignsStagedAdd" })
