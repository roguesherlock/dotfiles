return {
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    -- opts = {
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
    -- },
  },
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    dir = vim.fn.stdpath("config") .. "/local/plastic.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "modus",
    },
  },
}
