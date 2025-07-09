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
    enabled = not vim.g.vscode,
    opts = {
      keymap = {
        preset = "default",
      },
    },
  },
  -- {
  --   "ibhagwan/fzf-lua",
  --   keys = {
  --     { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
  --   },
  -- },
  {
    "echasnovski/mini.pairs",
    opts = {
      modes = { insert = true, command = false, terminal = false },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = not vim.g.vscode,
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
        virtual_text = { current_line = true, severity = { min = "INFO", max = "WARN" } },
        virtual_lines = { current_line = true, severity = { min = "ERROR" } },
      },
    },
  },
  {
    "folke/snacks.nvim",
    -- keys = {
    --   -- we want to set root = false here cause by default this falls back to individual packages in typescript monorepos
    --   {
    --     "<leader><space>",
    --     function()
    --       Snacks.picker.git_files({ untracked = true })
    --     end,
    --     desc = "Find Files (Git)",
    --   },
    --   { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (cwd)" },
    --   { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (Root Dir)" },
    --   { "<leader>sW", LazyVim.pick("grep_word"), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },
    --   {
    --     "<leader>sw",
    --     LazyVim.pick("grep_word", { root = false }),
    --     desc = "Visual selection or word (Root Dir)",
    --     mode = { "n", "x" },
    --   },
    -- },
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
      picker = {
        enabled = false,
        formatters = {
          file = {
            truncate = 80,
          },
        },
      },
    },
  },
}
