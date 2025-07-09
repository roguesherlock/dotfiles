return {
  { "windwp/nvim-ts-autotag" },
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
      indent = {
        enabled = false,
      },
      notifier = { enabled = false },
    },
    keys = {
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<c-/>",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
      {
        "<c-_>",
        function()
          Snacks.terminal()
        end,
        desc = "which_key_ignore",
      },
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
      {
        "<leader>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
        mode = { "n", "v" },
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
    },
  },
  -- Trouble for diagnostics
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("trouble").setup({})
      local map = require("user.util").map
      map("n", "<leader>d", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle trouble diagnostics" })
      map("n", "<leader>q", "<cmd>Trouble qflist toggle<cr>", { desc = "Toggle trouble [Q]uickfix" })
    end,
  },

  -- Noice for better UI
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        notify = {
          enabled = false,
        },
        lsp = {
          hover = {
            silent = true,
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        views = {
          mini = {
            win_options = {
              winblend = 0,
            },
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      })
    end,
  },
  -- Todo comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("todo-comments").setup({
        signs = false,
      })
      local map = require("user.util").map
      map("n", "]t", function()
        require("todo-comments").jump_next({ "FIX", "TODO" })
      end, { desc = "Next todo comment" })

      map("n", "[t", function()
        require("todo-comments").jump_prev({ "FIX", "TODO" })
      end, { desc = "Previous todo comment" })

      map("n", "<leader>xt", "<cmd>TodoQuickFix<cr>", { desc = "Open Todo" })
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

      local map = require("user.util").map
      map({ "n", "v" }, "<leader>m", "<cmd>MCstart<cr>", { desc = "Multi Cursor" })
    end,
  },
}
