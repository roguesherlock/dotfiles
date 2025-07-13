return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {},
  },
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
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({})
    end,
  },

  {
    "echasnovski/mini.starter",
    config = function()
      local starter = require("mini.starter")
      local pad = string.rep(" ", 22)
      starter.setup({
        evaluate_single = true,
        items = {
          starter.sections.builtin_actions(),
          {
            name = "Restore session",
            action = [[lua require("persistence").load()]],
            section = "Sessions",
          },
          starter.sections.recent_files(5, true),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", false),
          starter.gen_hook.indexing("all", { "Builtin actions", "Sessions" }),
          starter.gen_hook.aligning("center", "center"),
        },
      })
    end,
  },
  -- Zen mode for distraction-free writing
  {
    "folke/zen-mode.nvim",
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
