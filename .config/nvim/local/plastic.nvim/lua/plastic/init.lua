local M = {}
local config = require("plastic.config")

-- Color palette
local colors = {
  bg = "#21252B",
  bg_dark = "#181A1F",
  bg_darker = "#0D1117",
  fg = "#A9B2C3",
  fg_light = "#C6CCD7",
  fg_dark = "#5F6672",
  blue = "#61AFEF",
  cyan = "#56B6C2",
  green = "#98C379",
  purple = "#B57EDC",
  red = "#E06C75",
  red_dark = "#D74E42",
  orange = "#D19A66",
  yellow = "#E5C07B",
  yellow_light = "#E9D16C",
  accent = "#1085FF",
  none = "NONE",
}

function M.setup(opts)
  -- Apply user options
  config.setup(opts)

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Use transparent background if enabled
  local bg = config.options.transparent and colors.none or colors.bg
  local bg_dark = config.options.transparent and colors.none or colors.bg_dark

  -- Editor
  hi("Normal", { fg = colors.fg, bg = bg })
  hi("NormalFloat", { fg = colors.fg, bg = bg_dark })
  hi("ColorColumn", { bg = bg_dark })
  hi("Cursor", { fg = bg, bg = colors.fg })
  hi("CursorLine", { bg = bg_dark })
  hi("CursorLineNr", { fg = colors.fg_light })
  hi("LineNr", { fg = colors.fg_dark })
  hi("Directory", { fg = colors.blue })
  hi("DiffAdd", { fg = colors.green })
  hi("DiffChange", { fg = colors.orange })
  hi("DiffDelete", { fg = colors.red })
  hi("DiffText", { fg = colors.blue })

  -- Floating windows
  hi("FloatBorder", { fg = colors.accent })
  hi("FloatTitle", { fg = colors.accent })

  -- Search
  hi("Search", { fg = bg, bg = colors.accent })
  hi("IncSearch", { fg = bg, bg = colors.accent })

  -- Status line
  hi("StatusLine", { fg = colors.fg, bg = bg_dark })
  hi("StatusLineNC", { fg = colors.fg_dark, bg = colors.bg_darker })

  -- Syntax highlighting
  hi("Comment", { fg = colors.fg_dark, italic = true })
  hi("Constant", { fg = colors.cyan })
  hi("String", { fg = colors.green })
  hi("Character", { fg = colors.green })
  hi("Number", { fg = colors.cyan })
  hi("Boolean", { fg = colors.cyan })
  hi("Float", { fg = colors.cyan })
  hi("Identifier", { fg = colors.fg_light })
  hi("Function", { fg = colors.purple })
  hi("Statement", { fg = colors.red })
  hi("Conditional", { fg = colors.red })
  hi("Repeat", { fg = colors.red })
  hi("Label", { fg = colors.red })
  hi("Operator", { fg = colors.fg_dark })
  hi("Keyword", { fg = colors.red })
  hi("Exception", { fg = colors.red })
  hi("PreProc", { fg = colors.yellow })
  hi("Include", { fg = colors.blue })
  hi("Define", { fg = colors.purple })
  hi("Title", { fg = colors.blue })
  hi("Type", { fg = colors.yellow })
  hi("StorageClass", { fg = colors.blue })
  hi("Structure", { fg = colors.blue })
  hi("Special", { fg = colors.orange })
  hi("SpecialComment", { fg = colors.fg_dark, italic = true })
  hi("Error", { fg = colors.red_dark })
  hi("Todo", { fg = colors.yellow_light, bold = true })
  hi("jsxComponentName", { fg = colors.blue })
  hi("jsxTagName", { fg = colors.blue })

  -- Treesitter
  hi("@variable", { fg = colors.fg_light })
  hi("@function", { fg = colors.purple })
  hi("@function.builtin", { fg = colors.purple })
  hi("@keyword", { fg = colors.red })
  hi("@string", { fg = colors.green })
  hi("@number", { fg = colors.cyan })
  hi("@boolean", { fg = colors.cyan })
  hi("@type", { fg = colors.yellow })
  hi("@parameter", { fg = colors.fg_light })
  hi("@field", { fg = colors.fg_light })
  hi("@property", { fg = colors.fg_light })
  hi("@constructor", { fg = colors.yellow })
  hi("@conditional", { fg = colors.red })
  hi("@repeat", { fg = colors.red })
  hi("@constant", { fg = colors.cyan })
  hi("@constant.builtin", { fg = colors.cyan })
  hi("@tag.component", { fg = colors.blue })

  -- Git
  hi("GitSignsAdd", { fg = colors.green })
  hi("GitSignsChange", { fg = colors.orange })
  hi("GitSignsDelete", { fg = colors.red })

  -- Diagnostic
  hi("DiagnosticError", { fg = colors.red_dark })
  hi("DiagnosticWarn", { fg = colors.yellow_light })
  hi("DiagnosticInfo", { fg = colors.blue })
  hi("DiagnosticHint", { fg = colors.fg_dark })
end

return M
