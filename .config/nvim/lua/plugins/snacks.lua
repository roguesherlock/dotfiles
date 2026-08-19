return {
  -- Snacks for various utilities
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  enabled = true,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = true },
    indent = {
      enabled = false,
      only_scope = true,
      hl = "LineNr",
      animate = {
        enabled = true,
      },
      scope = {
        enabled = true,
        underline = false,
      },
      chunk = {
        enabled = false,
      },
    },
    input = { enabled = false },
    notifier = { enabled = false },
    picker = {
      enabled = false,
      matcher = {},
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
    -- stylua: ignore
    keys = {
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit", },
      { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal", mode = { "n", "t" }, },
      { "<d-j>", function() Snacks.terminal() end, desc = "Toggle Terminal", mode = { "n", "t" }, },
      -- { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History", },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" }, },
      { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer", },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>E", function() Snacks.explorer() end, desc = "Explorer Snacks (cwd)" },
      { "<d-b>", function() Snacks.explorer() end, desc = "Explorer Snacks (cwd)"},
    },
}
