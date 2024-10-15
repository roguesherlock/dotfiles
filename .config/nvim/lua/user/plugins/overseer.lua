return {
  {
    'stevearc/overseer.nvim',
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerRunCmd',
      'OverseerRun',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearCache',
    },
    opts = {
      dap = false,
      task_list = {
        bindings = {
          ['<C-h>'] = false,
          ['<C-j>'] = false,
          ['<C-k>'] = false,
          ['<C-l>'] = false,
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
    },
    -- stylua: ignore
    keys = {
      { "<leader>wtl", "<cmd>OverseerToggle<cr>",      desc = "[W]orkspace [T]asks [L]ist" },
      { "<leader>wtr", "<cmd>OverseerRun<cr>",         desc = "[W]orkspace [T]asks [R]un" },
      { "<leader>wtq", "<cmd>OverseerQuickAction<cr>", desc = "[W]orkspace [T]asks [Q]uick Run" },
      { "<leader>wti", "<cmd>OverseerInfo<cr>",        desc = "[W]orkspace [T]asks [I]nfo" },
      { "<leader>wtb", "<cmd>OverseerBuild<cr>",       desc = "[W]orkspace [T]asks [B]uilder" },
      { "<leader>wta", "<cmd>OverseerTaskAction<cr>",  desc = "[W]orkspace [T]asks [A]ction" },
      { "<leader>wtc", "<cmd>OverseerClearCache<cr>",  desc = "[W]orkspace [T]asks [C]lear cache" },
    },
  },
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      spec = {
        { '<leader>wt', group = '[T]asks' },
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    optional = true,
    opts = function()
      require('overseer').enable_dap()
    end,
  },
}
