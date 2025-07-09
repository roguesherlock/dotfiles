return {
  { "echasnovski/mini.comment" },
  { "echasnovski/mini.indentscope" },
  {
    "saghen/blink.indent",
    enabled = false,
    opts = {},
  },
  { "echasnovski/mini.ai" },
  -- { "echasnovski/mini.pairs", enabled = false },
  {
    "saghen/blink.pairs",
    version = "*",
    dependencies = "saghen/blink.download",
    opts = {},
  },
  { "echasnovski/mini.hipatterns" },
  { "echasnovski/mini.splitjoin" },
  -- Snacks for various utilities
  {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
      notifier = { enabled = false },
    },
    keys = {},
  },

  -- Overseer for task running
  {
    "stevearc/overseer.nvim",
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

      local map = require("config.keymaps").map
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

  -- Markdown rendering
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "quarto", "rmd", "codecompanion", "Avante", "avante" },
    config = function()
      require("markview").setup({
        filetypes = { "markdown", "quarto", "rmd", "codecompanion", "Avante", "avante" },
      })
    end,
  },

  -- Multi-cursor support
  {
    "smoka7/multicursors.nvim",
    dependencies = {
      "nvimtools/hydra.nvim",
    },
    cmd = "MCstart",
    config = function()
      require("multicursors").setup({})

      local map = require("config.keymaps").map
      map({ "n", "v" }, "<leader>m", "<cmd>MCstart<cr>", { desc = "Multi Cursor" })
    end,
  },
}
