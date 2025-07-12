return {
  {
    dir = "~/.config/nvim/lua",
    name = "user.colorscheme",
    priority = 1000,
    config = function()
      require("user.colorscheme").setup({})
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "folke/tokyonight.nvim",
    opts = {
      day_brightness = 0.2,
    },
  },
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      -- line_nr_column_background = false,
      -- sign_column_background = false,
      -- styles = {
      --   functions = {
      --     italic = true,
      --   },
      -- },
      -- on_highlights = function(h, c)
      --   local bg = c.bg_dim
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
      -- end,
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    enabled = false,
  },
  { "savq/melange-nvim", lazy = false, priority = 1000 },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    dependencies = "rktjmp/lush.nvim",
  },
}
