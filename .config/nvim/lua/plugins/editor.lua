return {
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require("tiny-inline-diagnostic").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
    },
  },
  {
    "chrisgrieser/nvim-recorder",
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
    enabled = false,
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
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim",
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
        fuzzy_finder_mappings = {
          ["<C-j>"] = "move_cursor_down",
          ["<C-k>"] = "move_cursor_up",
        },
      },
    },
  },
  {
    "NeogitOrg/neogit",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    config = function()
      require("neogit").setup({
        integrations = {
          telescope = true,
          diffview = true,
        },
      })
    end,
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
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
  -- fold
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      { "kevinhwang91/promise-async" },
    },
    config = function()
      local ufo = require("ufo")

      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      -- global handler
      -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
      -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
      ufo.setup({
        close_fold_kinds_for_ft = {
          default = { "imports", "comment" },
          json = { "array" },
          c = { "comment", "region" },
        },
        open_fold_hl_timeout = 0,
        provider_selector = function(_, filetype)
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
          local _start = lnum - 1
          local _end = end_lnum - 1
          local start_text = vim.api.nvim_buf_get_text(0, _start, 0, _start, -1, {})[1]
          local final_text = vim.trim(vim.api.nvim_buf_get_text(0, _end, 0, _end, -1, {})[1])
          return start_text .. " ⋯ " .. final_text .. (" 󰁂 %d "):format(end_lnum - lnum)
        end,
      })

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          -- choose one of coc.nvim and nvim lsp
          -- vim.fn.CocActionAsync('definitionHover') -- coc.nvim
          vim.lsp.buf.hover()
        end
      end)
    end,
  },
}
