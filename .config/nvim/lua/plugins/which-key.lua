return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
      local wk = require("which-key")
      wk.setup({
        preset = "helix",
        -- Document existing key chains
        spec = {
          { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
          { "<leader>d", group = "[D]ocument" },
          { "<leader>r", group = "[R]ename" },
          { "<leader>s", group = "[S]earch" },
          { "<leader>b", group = "[B]uffer" },
          { "<leader>g", group = "[G]it" },
          { "<leader>w", group = "[W]orkspace" },
          { "<leader>wt", group = "[W]orkspace [T]asks" },
          { "<leader>t", group = "[T]oggle" },
          { "<leader>tg", group = "[T]oggle [G]it" },
          { "<leader>l", group = "[L]SP" },
          { "<leader>gh", group = "[G]it [H]unk", mode = { "n", "v" } },
          { "<leader>a", group = "[A]i", mode = { "n", "v" } },
          { "w", proxy = "<c-w>", group = "[W]indow" },
        },
      })
      local map = require("user.util").map
      map("n", "<leader>?", function()
        wk.show({ global = false })
      end, { desc = "[?] Show buffer keymaps" })
    end,
  },
}
