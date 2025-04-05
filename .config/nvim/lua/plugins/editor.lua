return {
  {
    "bassamsdata/namu.nvim",
    enabled = false,
    config = function()
      require("namu").setup({
        -- Enable the modules you want
        namu_symbols = {
          enable = true,
          options = {}, -- here you can configure namu
        },
        -- Optional: Enable other modules if needed
        colorscheme = {
          enable = false,
          options = {
            -- NOTE: if you activate persist, then please remove any vim.cmd("colorscheme ...") in your config, no needed anymore
            persist = true, -- very efficient mechanism to Remember selected colorscheme
            write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
          },
        },
        ui_select = { enable = false }, -- vim.ui.select() wrapper
      })
      -- === Suggested Keymaps: ===
      local namu = require("namu.namu_symbols")
      local colorscheme = require("namu.colorscheme")
      vim.keymap.set("n", "<leader>ss", namu.show, {
        desc = "Jump to LSP symbol",
        silent = true,
      })
      vim.keymap.set("n", "<leader>th", colorscheme.show, {
        desc = "Colorscheme Picker",
        silent = true,
      })
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    enabled = false,
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },
  {
    "chrisgrieser/nvim-recorder",
    enabled = false,
    keys = {
      -- these must match the keys in the mapping config below
      { "q", desc = " Start Recording" },
      { "Q", desc = " Play Recording" },
    },
    opts = {
      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
      },
    },
  },
  {
    "leath-dub/snipe.nvim",
    enabled = true,
    keys = {
      {
        "gb",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
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
    },
  },
  -- {
  --   "folke/zen-mode.nvim",
  --   dependencies = {
  --     "folke/twilight.nvim",
  --   },
  --   keys = {
  --     { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
  --   },
  -- },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
        php = { "pint" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "blade",
      },
    },
    config = function(_, opts)
      -- Blade --
      -- Filetypes --
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })
      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }
    end,
  },
}
