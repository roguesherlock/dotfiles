return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "*",
    build = "cargo build --release",
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default", ["<cr>"] = { "select_and_accept", "fallback" } },
      completion = {
        ghost_text = { enabled = false },
        list = { selection = { preselect = true, auto_insert = false } },
      },
      sources = {},
    },
    config = function(_, opts)
      vim.g.completion = "blink"
      require("blink.cmp").setup(opts)
    end,
  },
}
