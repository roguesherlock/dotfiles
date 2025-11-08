return {
  { "windwp/nvim-ts-autotag" },
  -- Trouble for diagnostics
  {
    "folke/trouble.nvim",
    enabled = false,
    cmd = "Trouble",
    event = "VeryLazy",
    config = function()
      require("trouble").setup({})
      local map = require("user.util").map
      map("n", "<leader>d", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle trouble diagnostics" })
      map("n", "<leader>q", "<cmd>Trouble qflist toggle<cr>", { desc = "Toggle trouble [Q]uickfix" })
    end,
  },
  {
    "j-hui/fidget.nvim",
    enabled = true,
    opts = {
      notification = {
        override_vim_notify = true, -- Automatically override vim.notify() with Fidget
        window = {
          max_width = 0,
        },
      },
    },
  },

  -- Noice for better UI
  {
    "folke/noice.nvim",
    enabled = false,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "<leader>sn","<cmd>NoiceFzf<cr>" , desc = "[S]earch [N]oice", },
    },
    config = function()
      require("noice").setup({
        notify = {
          view = "mini",
        },
        lsp = {
          hover = {
            enabled = false,
          },
          signature = {
            enabled = false,
          },
          message = {
            view = "mini",
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            -- ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            -- ["vim.lsp.util.stylize_markdown"] = true,
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
      -- stylua: ignore start
      map("n", "]t", function() require("todo-comments").jump_next({ "FIX", "TODO" }) end, { desc = "Next todo comment" })
      map("n", "[t", function() require("todo-comments").jump_prev({ "FIX", "TODO" }) end, { desc = "Previous todo comment" })
      map("n", "<leader>xt", "<cmd>TodoQuickFix<cr>", { desc = "Open Todo" })
      -- stylua: ignore end
    end,
  },

  -- Markdown rendering
  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "quarto", "rmd", "codecompanion", "Avante", "avante" },
    config = function()
      require("markview").setup({
        preview = {
          filetypes = { "markdown", "quarto", "rmd", "codecompanion", "Avante", "avante" },
        },
      })
    end,
  },

  -- Multi-cursor support
  {
    "smoka7/multicursors.nvim",
    enabled = false,
    event = "VeryLazy",
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
  -- Terminal
  {
    "waiting-for-dev/ergoterm.nvim",
    enabled = false,
    config = function()
      require("ergoterm").setup()
    end,
  },
}
