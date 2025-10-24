return {
  "mikesmithgh/kitty-scrollback.nvim",
  name = "kitty-scrollback",
  lazy = true,
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth", "KittyScrollbackGenerateCommandLineEditing" },
  event = { "User KittyScrollbackLaunch" },
  opts = {},
}
