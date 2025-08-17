return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    keys = {
      { "<leader>ft", "<cmd>Neotree<cr>", desc = "[F]ile [T]ree" },
    },
    opts = {},
  },
}
