return {
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      line_nr_column_background = false,
      sign_column_background = false,
      -- styles = {
      --   functions = {
      --     italic = true,
      --   },
      -- },
      --   on_highlights = function(h, c)
      --     h.LeapLabel = { fg = c.fg_main, bg = c.bg_yellow_intense }
      --     local bg = h.LineNr and h.LineNr.bg or c.bg_main
      --     h.DiagnosticSignWarn = { bg = bg, fg = c.yellow }
      --     h.DiagnosticSignError = { bg = bg, fg = c.red }
      --     h.DiagnosticSignHint = { bg = bg, fg = c.cyan }
      --     h.DiagnosticSignInfo = { bg = bg, fg = c.blue }
      --     -- NOTE: this is for all the todo diagnostics
      --     -- h.SignColumn = { bg = bg }
      --     -- h.TodoSignTEST = { bg = bg, fg = c.red }
      --     -- h.TodoSignPERF = { bg = bg, fg = c.yellow }
      --     -- h.TodoSignFIX = { bg = bg, fg = c.green }
      --     -- h.TodoSignWARN = { bg = bg, fg = c.yellow }
      --     -- h.TodoSignHACK = { bg = bg, fg = c.red }
      --     -- h.TodoSignNOTE = { bg = bg, fg = c.cyan }
      --     -- h.TodoSignTODO = { bg = bg, fg = c.blue }
      --   end,
    },
  },
  -- {
  --   "0xstepit/flow.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },
  -- {
  --   "comfysage/evergarden",
  --   priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
  --   opts = {
  --     -- transparent_background = true,
  --     variant = "medium", -- 'hard'|'medium'|'soft'
  --     overrides = {}, -- add custom overrides
  --   },
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },
  { "savq/melange-nvim", priority = 1000 },
  { "ribru17/bamboo.nvim", enabled = false, priority = 1000 },
  -- {
  --   "zenbones-theme/zenbones.nvim",
  --   dependencies = {
  --     "rktjmp/lush.nvim",
  --   },
  --   priority = 1000,
  -- },
  -- {
  --   dir = vim.fn.stdpath("config") .. "/local/plastic.nvim",
  -- },
  {
    "nickkadutskyi/jb.nvim",
    enabled = false,
    priority = 1000,
    opts = {},
  },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "modus",
  --   },
  -- },
}
