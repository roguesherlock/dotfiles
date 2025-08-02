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
    "hyperb1iss/silkcircuit-nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    }
  },
  {
    "vague2k/vague.nvim",
    priority = 1000,
    opts = {
      transparent = true
    }
  },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      background = {    -- map the value of 'background' option to a theme
        dark = "zen",   -- try "zen", "mist" or "pearl" !
        light = "pearl" -- try "zen", "mist" or "pearl" !
      },
      foreground = {
        dark = "default",   -- Use default colors in dark mode
        light = "saturated" -- Use higher saturation in light mode
      },
    }
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
      -- highlight_overrides = {
      --   latte = function(colors)
      --     return {
      --       -- surface0 and 1 is used as a background color most of the time,
      --       -- but also as a foreground color in some cases. This makes it
      --       -- impossible to ensure contrast in all cases.
      --       -- For this reason, we replace all surface foreground colors with
      --       -- other surface colors to increase contrast.
      --       -- (surface2 is a rare color which is exclusively used as a
      --       -- foreground color)
      --       --
      --       -- surface0:
      --       SnacksIndent = { fg = colors.surface1 },
      --       IblIndent = { fg = colors.surface1 },
      --
      --       -- surface1:
      --       SignColumn = { fg = colors.surface2 }, -- column where |signs| are displayed
      --       SignColumnSB = { fg = colors.surface2 }, -- column where |signs| are displayed
      --
      --       LineNr = { fg = colors.surface2 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' o…
      --       TreesitterContextLineNumber = { fg = colors.surface2 },
      --       CursorLineNr = { fg = colors.blue }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
      --
      --       DapUIUnavailable = { fg = colors.surface2 },
      --
      --       GitSignsCurrentLineBlame = { fg = colors.surface2 },
      --
      --       -- More contrast menus:
      --       Pmenu = { bg = colors.mantle, fg = colors.overlay2 }, -- Popup menu: normal item.
      --       PmenuSel = { bg = colors.surface1, style = { "bold" } }, -- Popup menu: selected item.
      --
      --       -- More contrast for window separator:
      --       WinSeparator = { fg = colors.surface2 }, -- Separator between windows.
      --     }
      --   end,
      --   mocha = function(colors)
      --     return {
      --       -- surface0 and 1 is used as a background color most of the time,
      --       -- but also as a foreground color in some cases. This makes it
      --       -- impossible to ensure contrast in all cases.
      --       -- For this reason, we replace all surface foreground colors with
      --       -- other surface colors to increase contrast.
      --       -- (surface2 is a rare color which is exclusively used as a
      --       -- foreground color)
      --       --
      --       -- surface0:
      --       SnacksIndent = { fg = colors.surface1 },
      --       IblIndent = { fg = colors.surface1 },
      --
      --       -- surface1:
      --       SignColumn = { fg = colors.surface2 }, -- column where |signs| are displayed
      --       SignColumnSB = { fg = colors.surface2 }, -- column where |signs| are displayed
      --
      --       LineNr = { fg = colors.surface2 }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' o…
      --       TreesitterContextLineNumber = { fg = colors.surface2 },
      --       CursorLineNr = { fg = colors.blue }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
      --
      --       DapUIUnavailable = { fg = colors.surface2 },
      --
      --       GitSignsCurrentLineBlame = { fg = colors.surface2 },
      --
      --       -- More contrast menus:
      --       Pmenu = { bg = colors.mantle, fg = colors.overlay2 }, -- Popup menu: normal item.
      --       PmenuSel = { bg = colors.surface1, style = { "bold" } }, -- Popup menu: selected item.
      --
      --       -- More contrast for window separator:
      --       WinSeparator = { fg = colors.surface2 }, -- Separator between windows.
      --     }
      --   end,
      -- },
      -- color_overrides = {
      --   latte = {
      --     mauve = "#6A67B4",
      --     pink = "#6A67B4",
      --     flamingo = "#A352A0",
      --     rosewater = "#A352A0",
      --     red = "#C34165",
      --     maroon = "#C34165",
      --     yellow = "#8A7400",
      --     peach = "#AC591C",
      --     green = "#288043",
      --     teal = "#007E7D",
      --     sky = "#007E7D",
      --     sapphire = "#007E7D",
      --     blue = "#1675AB",
      --     lavender = "#1675AB",
      --     text = "#706F7A",
      --     subtext1 = "#757480",
      --     subtext0 = "#757480",
      --     overlay2 = "#797985",
      --     overlay1 = "#7E7D8A",
      --     overlay0 = "#84828F",
      --     surface2 = "#9C8282",
      --     surface1 = "#EBDFD3",
      --     surface0 = "#EBDFD3",
      --     base = "#FAF4ED",
      --     mantle = "#FCF9F5",
      --     crust = "#FCF9F5",
      --   },
      --   mocha = {
      --     mauve = "#A19DD4",
      --     pink = "#A19DD4",
      --     flamingo = "#C394C2",
      --     rosewater = "#C394C2",
      --     red = "#DF8BA0",
      --     maroon = "#DF8BA0",
      --     yellow = "#C7B96F",
      --     peach = "#C79A76",
      --     green = "#75B087",
      --     teal = "#5EB1AF",
      --     sky = "#5EB1AF",
      --     sapphire = "#5EB1AF",
      --     blue = "#7AA8CE",
      --     lavender = "#7AA8CE",
      --     text = "#A2A2A9",
      --     subtext1 = "#878794",
      --     subtext0 = "#878794",
      --     overlay2 = "#7D7D7D",
      --     overlay1 = "#808084",
      --     overlay0 = "#84848C",
      --     surface2 = "#7C7992",
      --     surface1 = "#37363E",
      --     surface0 = "#37363E",
      --     base = "#191724",
      --     mantle = "#0B0A0F",
      --     crust = "#0B0A0F",
      --   },
      -- },
      -- dark pink version
      -- color_overrides = {
      --   mocha = {
      --     rosewater = "#808080", -- gray
      --     flamingo = "#ffc0ff", -- pastel pink
      --     mauve = "#ffffff", -- whitest white
      --     pink = "#ff40ff", -- deep pink
      --     red = "#ff0000", -- reddest red
      --     maroon = "#d000ff", -- light purple
      --     peach = "#ff8000", -- more orange
      --     yellow = "#ff0080", -- yellow is gross, make it peach
      --     green = "#ff80ff", -- equidistant pink
      --     teal = "#00ffff", -- true teal
      --     sky = "#0080ff", -- light(er) blue
      --     sapphire = "#a000ff", -- dark purple
      --     blue = "#8080ff", -- gray blue
      --     lavender = "#ff00ff", -- pinkest pink
      --     text = "#cc00cc", -- pinks all the way down
      --     subtext1 = "#bb00bb",
      --     subtext0 = "#aa00aa",
      --     overlay2 = "#990099",
      --     overlay1 = "#880088",
      --     overlay0 = "#770077",
      --     surface2 = "#660066",
      --     surface1 = "#550055",
      --     surface0 = "#440044",
      --     crust = "#330033",
      --     mantle = "#220022",
      --     base = "#110011",
      --   },
      -- },
      -- everforest version
      color_overrides = {
        mocha = {
          -- custom everforest dark hard port
          rosewater = "#fed1cb",
          flamingo = "#ff9185",
          pink = "#d699b6",
          mauve = "#cb7ec8",
          red = "#e06062",
          maroon = "#e67e80",
          peach = "#e69875",
          yellow = "#d3ad63",
          green = "#b0cc76",
          teal = "#6db57f",
          sky = "#7fbbb3",
          sapphire = "#60aaa0",
          blue = "#59a6c3",
          lavender = "#e0d3d4",
          text = "#e8e1bf",
          subtext1 = "#e0d7c3",
          subtext0 = "#d3c6aa",
          overlay2 = "#9da9a0",
          overlay1 = "#859289",
          overlay0 = "#6d6649",
          surface2 = "#585c4a",
          surface1 = "#414b50",
          surface0 = "#374145",
          base = "#1f2428",
          mantle = "#161b1d",
          crust = "#14181a",
        },
        latte = {
          -- custom everforest light hard port
          rosewater = "#a43b35",
          flamingo = "#da3537",
          pink = "#d332a1",
          mauve = "#aa3685",
          red = "#ff3532",
          maroon = "#de3631",
          peach = "#f36c0b",
          yellow = "#bd8800",
          green = "#596600",
          teal = "#287e5e",
          sky = "#52b1c7",
          sapphire = "#3fb4b8",
          blue = "#317da7",
          lavender = "#474155",
          text = "#4d4742",
          subtext1 = "#5b5549",
          subtext0 = "#6d6655",
          overlay2 = "#786d5a",
          overlay1 = "#8c7c62",
          overlay0 = "#a18d66",
          surface2 = "#c9bea5",
          surface1 = "#d8d3ba",
          surface0 = "#e8e2c8",
          base = "#ebe4c8",
          mantle = "#e1dab5",
          crust = "#bdc0a0",
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
    },
  },
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      line_nr_column_background = false,
      sign_column_background = false,
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
  { "savq/melange-nvim", enabled = false, lazy = false, priority = 1000 },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    enabled = false,
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
      vim.g.gruvbox_material_float_style = "dim"  -- Background of floating windows
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
