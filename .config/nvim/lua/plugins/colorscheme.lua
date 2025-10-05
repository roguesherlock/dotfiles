return {
  {
    dir = "~/.config/nvim/lua",
    name = "user.colorscheme",
    priority = 1000,
    config = function()
      require("user.colorscheme").setup({})
    end,
  },
  -- {
  --   "darianmorat/gruvdark.nvim",
  --   priority = 1000,
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  -- {
  --   "tinted-theming/tinted-vim",
  --   enabled = false,
  -- },
  -- {
  --   "nyoom-engineering/oxocarbon.nvim",
  --   event = "VeryLazy",
  --   priority = 1000,
  -- },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   event = "VeryLazy",
  --   priority = 1000,
  -- },
  -- {
  --   "sainnhe/gruvbox-material",
  --   event = "VeryLazy",
  --   priority = 1000,
  -- },
  -- {
  --   "loctvl842/monokai-pro.nvim",
  --   event = "VeryLazy",
  --   priority = 1000,
  -- },
  -- {
  --   "ribru17/bamboo.nvim",
  --   event = "VeryLazy",
  --   priority = 1000,
  --   opts = {},
  -- },
  -- {
  --   "Mofiqul/vscode.nvim",
  --   event = "VeryLazy",
  --   priority = 1000,
  -- },
  -- {
  --   "hyperb1iss/silkcircuit-nvim",
  --   event = "VeryLazy",
  --   priority = 1000,
  -- },
  -- {
  --   "vague2k/vague.nvim",
  --   event = "VeryLazy",
  --   priority = 1000,
  -- },
  -- {
  --   "webhooked/kanso.nvim",
  --   event = "VeryLazy",
  --   priority = 1000,
  --   opts = {
  --     -- transparent = true,
  --     background = { -- map the value of 'background' option to a theme
  --       dark = "zen", -- try "zen", "mist" or "pearl" !
  --       light = "pearl", -- try "zen", "mist" or "pearl" !
  --     },
  --     foreground = {
  --       dark = "default", -- Use default colors in dark mode
  --       light = "saturated", -- Use higher saturation in light mode
  --     },
  --   },
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      term_colors = true,
      auto_integrations = true,
      -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "frappe",
      },
      -- transparent_background = true,
      float = {
        -- transparent = true, -- enable transparent floating windows
      },
      integrations = {
        native_lsp = {
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
            ok = { "undercurl" },
          },
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    -- event = "VeryLazy",
    priority = 1000,
    opts = {
      day_brightness = 0.2,
    },
  },
  {
    "miikanissi/modus-themes.nvim",
    -- event = "VeryLazy",
    priority = 1000,
    opts = {
      -- transparent = true,
      line_nr_column_background = false,
      sign_column_background = false,
      -- styles = {
      --   functions = {
      --     italic = true,
      --   },
      -- },
      on_colors = function(colors)
        -- colors.bg_main = colors.bg_dim
        colors.bg_main = colors.bg_alt
      end,
      on_highlights = function(h, c)
        local bg = c.bg_dim
        h.WhichKeyBorder = { fg = c.border, bg = c.bg_alt }
        h.WhichKeyFloat = { bg = c.bg_alt }
        h.NormalFloat = { bg = c.bg_alt }
        --
        --   h.SnacksPickerBorder = { fg = c.border, bg = bg }
        --   h.SnacksPickerFooter = { bg = bg }
        --   h.SnacksPickerTitle = { bg = bg, fg = c.border_highlight }
        --   h.SnacksPicker = { bg = bg }
        --   h.SnacksPickerCol = { bg = bg }
        --   h.SnacksPickerTree = { bg = bg }
        --
        --   h.NoiceCmdlinePopup = { bg = c.bg_main }
        --   h.NoiceCmdlineIcon = { bg = c.bg_main }
        --   h.NoiceCmdlinePopupBorder = { bg = c.bg_main }
        --
        --   -- h.LeapLabel = { fg = c.fg_main, bg = c.bg_yellow_intense }
        --   local bg_sidebar = c.bg_sidebar
        --   h.DiagnosticSignWarn = { bg = bg_sidebar, fg = c.yellow }
        --   h.DiagnosticSignError = { bg = bg_sidebar, fg = c.red }
        --   h.DiagnosticSignHint = { bg = bg_sidebar, fg = c.cyan }
        --   h.DiagnosticSignInfo = { bg = bg_sidebar, fg = c.blue }
        --   -- NOTE: this is for all the todo diagnostics
        --   h.SignColumn = { bg = bg_sidebar }
        --   h.TodoSignTEST = { bg = bg_sidebar, fg = c.red }
        --   h.TodoSignPERF = { bg = bg_sidebar, fg = c.yellow }
        --   h.TodoSignFIX = { bg = bg_sidebar, fg = c.green }
        --   h.TodoSignWARN = { bg = bg_sidebar, fg = c.yellow }
        --   h.TodoSignHACK = { bg = bg_sidebar, fg = c.red }
        --   h.TodoSignNOTE = { bg = bg_sidebar, fg = c.cyan }
        --   h.TodoSignTODO = { bg = bg_sidebar, fg = c.blue }
      end,
    },
  },
  -- { "savq/melange-nvim", enabled = false, lazy = false, priority = 1000 },
  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000,
  --   enabled = false,
  --   config = function()
  --     vim.g.gruvbox_material_better_performance = 1
  --     vim.g.gruvbox_material_enable_italic = true
  --     -- Fonts
  --     vim.g.gruvbox_material_enable_bold = true
  --     vim.g.gruvbox_material_transparent_background = true
  --     -- Themes
  --     vim.g.gruvbox_material_foreground = "mix"
  --     vim.g.gruvbox_material_background = "hard"
  --     vim.g.gruvbox_material_ui_contrast = "high" -- The contrast of line numbers, indent lines, etc.
  --     vim.g.gruvbox_material_float_style = "dim" -- Background of floating windows
  --     -- vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
  --     -- vim.g.gruvbox_material_diagnostic_line_highlight = 1
  --     vim.g.gruvbox_material_current_word = "grey background"
  --
  --     local configuration = vim.fn["gruvbox_material#get_configuration"]()
  --     local palette = vim.fn["gruvbox_material#get_palette"](
  --       configuration.background,
  --       configuration.foreground,
  --       configuration.colors_override
  --     )
  --
  --     -- vim.cmd.colorscheme("gruvbox-material")
  --
  --     local highlights_groups = {
  --       FoldColumn = { bg = "none" },
  --       SignColumn = { bg = "none" },
  --       Normal = { bg = "none" },
  --       NormalNC = { bg = "none" },
  --       NormalFloat = { bg = "none" },
  --       FloatBorder = { bg = "none" },
  --       FloatTitle = { bg = "none", fg = palette.orange[1] },
  --       TelescopeBorder = { bg = "none" },
  --       TelescopeNormal = { fg = "none" },
  --       TelescopePromptNormal = { bg = "none" },
  --       TelescopeResultsNormal = { bg = "none" },
  --       TelescopeSelection = { bg = palette.bg3[1] },
  --       Visual = { bg = palette.bg_visual_red[1] },
  --       Cursor = { bg = palette.bg_red[1], fg = palette.bg_dim[1] },
  --       ColorColumn = { bg = palette.bg_visual_blue[1] },
  --       CursorLine = { bg = palette.bg3[1], blend = 25 },
  --       GitSignsAdd = { fg = palette.green[1], bg = "none" },
  --       GitSignsChange = { fg = palette.yellow[1], bg = "none" },
  --       GitSignsDelete = { fg = palette.red[1], bg = "none" },
  --     }
  --
  --     for group, styles in pairs(highlights_groups) do
  --       vim.api.nvim_set_hl(0, group, styles)
  --     end
  --   end,
  -- },
}
