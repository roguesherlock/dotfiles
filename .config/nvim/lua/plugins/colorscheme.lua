return {
  {
    "miikanissi/modus-themes.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(h, c)
        h.LeapLabel = { fg = c.fg_main, bg = c.bg_yellow_intense }
        -- TODO: figure out why the fuck is this not working
        h.SignColumn = { fg = c.fg_dim, bg = c.none }
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
