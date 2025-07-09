return {
  -- Grug-far for search and replace
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    config = function()
      local g = require("grug-far")
      g.setup({})

      local map = require("user.util").map
      map("n", "<leader>sr", function()
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        g.open({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end, {
        desc = "[S]earch and [R]eplace",
      })
      map("v", "<leader>sr", function()
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        g.with_visual_selection({
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end, {
        desc = "[S]earch and [R]eplace with selection as input",
      })
    end,
  },
}
