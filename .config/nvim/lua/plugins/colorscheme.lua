return {
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(h, c)
        h.LeapLabel = { fg = c.fg_main, bg = c.bg_yellow_intense }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "modus",
    },
  },
}
