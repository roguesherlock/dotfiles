return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- The following are optional:
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
    keys = {
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "[A]i Actions [P]rompt" },
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle [A]i Chat" },
      { "<leader>ac", "<cmd>CodeCompanionChat Add<cr>", mode = { "n", "v" }, desc = "[A]i add to [C]hat" },
    },
    config = true,
    opts = {
      strategies = {
        chat = {
          adapter = "anthropic",
          keymaps = {
            close = {
              modes = {
                n = "q",
                i = "q",
              },
            },
            stop = {
              modes = {
                n = "<C-c>",
              },
            },
          },
        },
      },
      display = {
        diff = {
          provider = "mini_diff",
        },
      },
    },
  },
}
