return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default", ["<cr>"] = { "select_and_accept", "fallback" } },
      completion = {
        ghost_text = { enabled = false },
        list = { selection = { preselect = true, auto_insert = false } },
        -- documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
      signature = { enabled = true },
      cmdline = {
        keymap = {
          preset = "inherit",
          -- recommended, as the default keymap will only show and select the next item
          ["<Tab>"] = { "show", "accept" },
        },
        completion = {
          menu = {
            auto_show = true,
          },
        },
      },
      sources = {},
    },
  },
}
