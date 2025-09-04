return {
  -- Overseer for task running
  {
    "stevearc/overseer.nvim",
    event = "VeryLazy",
    cmd = {
      "OverseerRun",
      "OverseerToggle",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    config = function()
      require("overseer").setup({
        dap = false,
        task_list = {
          bindings = {
            ["<C-h>"] = false,
            ["<C-j>"] = false,
            ["<C-k>"] = false,
            ["<C-l>"] = false,
          },
        },
        form = {
          win_opts = {
            winblend = 0,
          },
        },
        confirm = {
          win_opts = {
            winblend = 0,
          },
        },
        task_win = {
          win_opts = {
            winblend = 0,
          },
        },
      })

      local map = require("user.util").map
      map("n", "<leader>wtl", "<cmd>OverseerToggle<cr>", { desc = "[W]orkspace [T]asks [L]ist" })
      map("n", "<leader>wtr", "<cmd>OverseerRun<cr>", { desc = "[W]orkspace [T]asks [R]un" })
      map("n", "<leader>wtq", "<cmd>OverseerQuickAction<cr>", { desc = "[W]orkspace [T]asks [Q]uick Run" })
      map("n", "<leader>wti", "<cmd>OverseerInfo<cr>", { desc = "[W]orkspace [T]asks [I]nfo" })
      map("n", "<leader>wtb", "<cmd>OverseerBuild<cr>", { desc = "[W]orkspace [T]asks [B]uilder" })
      map("n", "<leader>wta", "<cmd>OverseerTaskAction<cr>", { desc = "[W]orkspace [T]asks [A]ction" })
      map("n", "<leader>wtc", "<cmd>OverseerClearCache<cr>", { desc = "[W]orkspace [T]asks [C]lear cache" })
    end,
  },

  -- Dashboard/session management
  {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
      { "<leader>wf", "<cmd>AutoSession search<CR>", desc = "[W]orkspace [F]ind" },
      { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "[W]orkspace [S]ave " },
      { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "[W]orkspace [A]utosave" },
    },
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      git_use_branch_name = true,
      git_auto_restore_on_branch_change = true,
      load_on_setup = true,
    },
  },

  -- Zen mode for distraction-free writing
  {
    "folke/zen-mode.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "folke/twilight.nvim" },
    cmd = "ZenMode",
    config = function()
      local map = require("user.util").map
      map("n", "<leader>z", ":ZenMode<cr>", { desc = "Toggle [Z]en mode" })
    end,
  },
  -- Nvim recorder for macros
  {
    "chrisgrieser/nvim-recorder",
    config = function()
      require("recorder").setup({
        mapping = {
          startStopRecording = "q",
          playMacro = "Q",
        },
      })
    end,
  },
}
