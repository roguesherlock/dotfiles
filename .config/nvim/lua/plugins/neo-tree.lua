return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right"
      },
      mappings = {
        ["<space>"] = {
          "toggle_node",
          nowait = false -- disable `nowait` if you have existing combos starting with this char that you want to use
        }
      }
    }
  }
}
