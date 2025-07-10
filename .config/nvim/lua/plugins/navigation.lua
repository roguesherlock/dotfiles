return {
  -- Leap for fast navigation
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_mappings()
    end,
  },

  -- Harpoon for quick file navigation
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        },
        settings = {
          save_on_toggle = true,
        },
      })

      local map = require("user.util").map
      map("n", "<leader>H", function()
        require("harpoon"):list():add()
      end, { desc = "Add Harpoon File" })

      map("n", "<leader>tp", function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "[T]oggle Har[P]oon Quick Menu" })

      for i = 1, 5 do
        map("n", "<leader>" .. i, function()
          require("harpoon"):list():select(i)
        end, { desc = "Harpoon to File " .. i })
      end
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
        },
        hints = {
          -- Charaters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
          dictionary = "sadflewvrcmnpghioty",
        },
        navigate = {
          next_page = "<c-n>",
          prev_page = "<c-p>",
          close_buffer = "<c-d>",
          open_vsplit = "<c-v>",
          open_hsplit = "<c-h>",
          cancel_snipe = "q",
        },
      })

      local map = require("user.util").map
      map("n", "gb", function()
        require("snipe").open_buffer_menu()
      end, { desc = "Open Snipe buffer menu" })
    end,
  },
}
