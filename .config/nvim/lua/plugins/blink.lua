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
      keymap = { preset = "default" },

    },
    config = function(_, opts)
      vim.g.completion = "blink"
      require("blink.cmp").setup(opts)
    end,
  },
}
