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
    enabled = false,
  },
  { "savq/melange-nvim", priority = 1000 },
  {
    "zenbones-theme/zenbones.nvim",
    enabled = false,
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },
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
