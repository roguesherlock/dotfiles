return {
  {
    dir = "~/.config/nvim/lua",
    name = "user.colorscheme",
    priority = 1000,
    config = function()
      require("user.colorscheme").setup({})
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        blink_cmp = {
          style = "bordered",
        },
        diffview = true,
        flash = true,
        fzf = true,
        harpoon = true,
        grug_far = true,
        leap = true,
        markdown = true,
        markview = true,
        mason = true,
        noice = true,
        copilot_vim = true,
        overseer = true,
        lsp_trouble = true,
        which_key = true,
      },
    },
  },
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
  { "savq/melange-nvim", lazy = false, priority = 1000 },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = true
      -- Fonts
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_transparent_background = true
      -- Themes
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high" -- The contrast of line numbers, indent lines, etc.
      vim.g.gruvbox_material_float_style = "dim" -- Background of floating windows
      -- vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
      -- vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_current_word = "grey background"

      local configuration = vim.fn["gruvbox_material#get_configuration"]()
      local palette = vim.fn["gruvbox_material#get_palette"](
        configuration.background,
        configuration.foreground,
        configuration.colors_override
      )

      -- vim.cmd.colorscheme("gruvbox-material")

      local highlights_groups = {
        FoldColumn = { bg = "none" },
        SignColumn = { bg = "none" },
        Normal = { bg = "none" },
        NormalNC = { bg = "none" },
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none", fg = palette.orange[1] },
        TelescopeBorder = { bg = "none" },
        TelescopeNormal = { fg = "none" },
        TelescopePromptNormal = { bg = "none" },
        TelescopeResultsNormal = { bg = "none" },
        TelescopeSelection = { bg = palette.bg3[1] },
        Visual = { bg = palette.bg_visual_red[1] },
        Cursor = { bg = palette.bg_red[1], fg = palette.bg_dim[1] },
        ColorColumn = { bg = palette.bg_visual_blue[1] },
        CursorLine = { bg = palette.bg3[1], blend = 25 },
        GitSignsAdd = { fg = palette.green[1], bg = "none" },
        GitSignsChange = { fg = palette.yellow[1], bg = "none" },
        GitSignsDelete = { fg = palette.red[1], bg = "none" },
      }

      for group, styles in pairs(highlights_groups) do
        vim.api.nvim_set_hl(0, group, styles)
      end
    end,
  },
}
