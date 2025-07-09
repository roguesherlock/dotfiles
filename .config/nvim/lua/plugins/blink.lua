return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "*",
    build = "cargo build --release",
    event = "InsertEnter",
    config = function()
      vim.g.completion = "blink"
      require("blink.cmp").setup({})
    end,
  },
}
