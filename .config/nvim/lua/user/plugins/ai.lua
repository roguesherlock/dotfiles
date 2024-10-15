return {
  {
    'supermaven-inc/supermaven-nvim',
    lazy = false,
    enabled = true,
    config = true,
    opts = {
      keymaps = {
        accept_suggestion = '<Tab>',
        clear_suggestion = '<C-]>',
        accept_word = '<C-,',
      },
    },
    keys = {
      { '<leader>ts', '<cmd>SupermavenToggle<cr>', desc = '[T]oggle [S]uperMaven' },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    keys = {
      { '<C-a>', '<cmd>CodeCompanionActions<cr>', desc = 'Ai [A]ctions' },
      { '<C-a>', '<cmd>CodeCompanionActions<cr>', mode = 'v', desc = 'Ai [A]ctions' },
      { '<Leader>ta', '<cmd>CodeCompanionChat Toggle<cr>', desc = '[T]oggle [A]i' },
      { '<Leader>ta', '<cmd>CodeCompanionChat Toggle<cr>', mode = 'v', desc = '[T]oggle [A]i' },
      { '<Leader>aa', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = '[A]dd to [A]i' },
    },
    config = true,
    -- config = function()
    --   require('codecompanion').setup()
    --   -- Expand 'cc' into 'CodeCompanion' in the command line
    --   vim.cmd [[cab cc CodeCompanion]]
    -- end,
  },
  {
    'yetone/avante.nvim',
    enabled = false,
    init = function()
      require('avante_lib').load()
    end,
    event = 'VeryLazy',
    opts = {
      hints = { enabled = false },
    },
    build = 'make',
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    optional = true,
    opts = function(_, opts)
      opts.file_types = vim.list_extend(opts.file_types or {}, { 'Avante' })
    end,
    ft = function(_, ft)
      vim.list_extend(ft, { 'Avante' })
    end,
  },
}
