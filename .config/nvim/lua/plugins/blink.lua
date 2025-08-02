return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = '1.*',
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default", ["<cr>"] = { "select_and_accept", "fallback" } },
      completion = {
        ghost_text = { enabled = false },
        list = { selection = { preselect = true, auto_insert = false } },
      },
      sources = {},
    },
  },
}
