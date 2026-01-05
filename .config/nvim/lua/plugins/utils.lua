return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {},
  },
  -- Overseer for task running
  {
    "stevearc/overseer.nvim",
    config = function()
      local overseer = require("overseer")
      overseer.setup({
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
      map("n", "<c-\\>", "<cmd>OverseerToggle<cr>", { desc = "[o]verseer [o]pen" })
      map("n", "<leader>oo", "<cmd>OverseerToggle<cr>", { desc = "[o]verseer [o]pen" })
      map("n", "<leader>oc", "<cmd>OverseerShell<cr>", { desc = "[o]verseer Run Shell [c]ommand" })
      map("n", "<leader>or", "<cmd>OverseerRun<cr>", { desc = "[o]verseer [r]un" })
      map("n", "<leader>oa", "<cmd>OverseerTaskAction<cr>", { desc = "[o]verseer [a]ction" })
      map("n", "<leader>wtl", "<cmd>OverseerToggle<cr>", { desc = "[w]orkspace [t]asks [l]ist" })
      map("n", "<leader>wtd", function()
        overseer.run_task({ cmd = { "bun", "run", "dev" } })
      end, { desc = "[w]orkspace [t]asks [d]ev" })
      map("n", "<leader>wtb", function()
        overseer.run_task({ cmd = { "bun", "run", "build" } })
      end, { desc = "[w]orkspace [t]asks [b]uild" })
      map("n", "<leader>wtt", function()
        overseer.run_task({ cmd = { "bun", "run", "lint" } })
      end, { desc = "[w]orkspace [t]asks [t]ype check" })
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
      -- TODO:: make this work
      git_auto_restore_on_branch_change = false,
      -- close_unsupported_windows = false,
      -- bypass_save_filetypes = { "snacks_terminal", "alpha", "lazy", "mason", "notify", "toggleterm", "OverseerList" },
      args_allow_single_directory = false,
      continue_restore_on_error = false,
      load_on_setup = true,
      preserve_buffer_on_restore = function(bufnr)
        local buf_type = vim.bo[bufnr].filetype
        vim.notify(buf_type)
        return buf_type == "snacks_terminal"
      end,
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
