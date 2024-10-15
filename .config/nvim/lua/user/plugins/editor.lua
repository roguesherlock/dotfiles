return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      window = {
        position = 'right',
        fuzzy_finder_mappings = {
          ['<C-j>'] = 'move_cursor_down',
          ['<C-k>'] = 'move_cursor_up',
        },
      },
    },
  },
  {
    'NeogitOrg/neogit',
    enabled = false,
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'nvim-telescope/telescope.nvim', -- optional
      'sindrets/diffview.nvim', -- optional
    },
    config = function()
      require('neogit').setup {
        integrations = {
          telescope = true,
          diffview = true,
        },
      }
    end,
    keys = {
      { '<leader>gn', '<cmd>Neogit<cr>', desc = 'Neogit' },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        blade = { 'blade-formatter' },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'blade',
      },
    },
    config = function(_, opts)
      -- Blade --
      -- Filetypes --
      vim.filetype.add {
        pattern = {
          ['.*%.blade%.php'] = 'blade',
        },
      }
      require('nvim-treesitter.configs').setup(opts)
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = { 'src/parser.c' },
          branch = 'main',
        },
        filetype = 'blade',
      }
    end,
  },
}
