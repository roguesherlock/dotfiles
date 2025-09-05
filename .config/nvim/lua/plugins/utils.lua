return {
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
      map("n", "<leader>ol", "<cmd>OverseerToggle<cr>", { desc = "[o]verseer [l]ist" })
      map("n", "<leader>oc", "<cmd>OverseerRunCmd<cr>", { desc = "[o]verseer Run [c]ommand" })
      map("n", "<leader>or", "<cmd>OverseerQuickAction<cr>", { desc = "[o]verseer [r]un" })
      map("n", "<leader>oR", "<cmd>OverseerRun<cr>", { desc = "[o]verseer [R]un" })
      map("n", "<leader>oi", "<cmd>OverseerInfo<cr>", { desc = "[o]verseer [i]nfo" })
      map("n", "<leader>ob", "<cmd>OverseerBuild<cr>", { desc = "[o]verseer [b]uild" })
      map("n", "<leader>oa", "<cmd>OverseerTaskAction<cr>", { desc = "[o]verseer [a]ction" })
      map("n", "<leader>oD", "<cmd>OverseerClearCache<cr>", { desc = "[o]verseer [D]elete cache" })

      map("n", "<leader>wtd", function()
        overseer.run_template({ name = "npm dev" })
        -- overseer.run_template({ name = "npm dev" }, function(task)
        --   if task then
        --     overseer.run_action(task, "open float")
        --   end
        -- end)
      end, { desc = "[w]orkspace [t]asks [d]ev" })

      map("n", "<leader>wtb", function()
        overseer.run_template({ name = "npm build" })
        -- overseer.run_template({ name = "npm build" }, function(task)
        --   if task then
        --     overseer.run_action(task, "open float")
        --   end
        -- end)
      end, { desc = "[w]orkspace [t]asks [b]uild" })

      map("n", "<leader>wtt", function()
        overseer.run_template({ name = "npm typecheck" })
        -- overseer.run_template({ name = "npm typecheck" }, function(task)
        --   if task then
        --     overseer.run_action(task, "open float")
        --   end
        -- end)
      end, { desc = "[w]orkspace [t]asks [t]ype check" })

      -- map("n", "<leader>wti", function()
      --   overseer.run_template({ name = "ni" }, function(task)
      --     if task then
      --       overseer.run_action(task, "open float")
      --     end
      --   end)
      -- end, { desc = "[w]orkspace [t]asks [i]nstall" })
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
