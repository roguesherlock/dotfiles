return {
  {
    "LazyVim/LazyVim",
    opts = {
      icons = {
        diagnostics = {
          Error = "●",
          Warn = "●",
          Hint = "●",
          Info = "●",
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
    },
  },
  {
    "echasnovski/mini.pairs",
    opts = {
      modes = { insert = true, command = false, terminal = false },
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
  -- {
  --   "Exafunction/codeium.nvim",
  --   opts = {
  --     virtual_text = {
  --       idle_delay = 0,
  --       -- enabled = true,
  --       -- key_bindings = {
  --       --   -- Accept the current completion.
  --       --   accept = "<Tab>",
  --       --   -- Cycle to the next completion.
  --       --   next = "<M-]>",
  --       --   -- Cycle to the previous completion.
  --       --   prev = "<M-[>",
  --       -- },
  --     },
  --   },
  -- },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = false,
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        enabled = false,
      },
      indent = {
        enabled = false,
        only_scope = true,
      },
      animate = {
        -- easing = "outQuart",
        -- easing = "outQuint",
        easing = "outExpo",
        duration = 10, -- ms per step
        fps = 120,
      },
    },
  },
}
