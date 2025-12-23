return {
  -- Leap for fast navigation
  {
    "ggandor/leap.nvim",
    enabled = false,
    config = function()
      require("leap").set_default_mappings()
      local map = require("user.util").map
      map({ "n", "x", "o" }, "r", function()
        require("leap.remote").action()
      end, { desc = "Leap remote action" })
    end,
  },

  -- Snipe for buffer navigation
  {
    "leath-dub/snipe.nvim",
    event = "VeryLazy",
    config = function()
      require("snipe").setup({
        ui = {
          position = "center",
          text_align = "file-first",
          open_win_override = {
            -- title = "My Window Title",
            border = "rounded", -- use "rounded" for rounded border
          },
        },
        hints = {
          -- Charaters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
          dictionary = "sadfewvrcmnpghioty",
        },
        navigate = {
          under_cursor = "l",
          next_page = "<c-n>",
          prev_page = "<c-p>",
          close_buffer = "<c-d>",
          open_vsplit = "<c-v>",
          open_hsplit = "<c-h>",
          cancel_snipe = "q",
          sort = "last",
        },
      })

      local map = require("user.util").map
      map("n", "f", function()
        require("snipe").open_buffer_menu()
      end, { desc = "Open Snipe buffer menu" })
    end,
  },
}
