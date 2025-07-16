return {
  -- Supermaven AI completion
  {
    "supermaven-inc/supermaven-nvim",
    event = { "InsertEnter", "VeryLazy" },
    config = function()
      require("supermaven-nvim").setup({ log_level = "off" })
      local map = require("user.util").map
      -- Trigger completion with <tab> manually since mini.completion doesn't play well with supermaven
      map("i", "<tab>", function()
        local suggestion = require("supermaven-nvim.completion_preview")
        if suggestion.has_suggestion() then
          suggestion.on_accept_suggestion()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<tab>", true, false, true), "n", true)
        end
      end, { desc = "Accept Supermaven suggestion" })
    end,
  },

  -- CodeCompanion AI chat
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    event = "VeryLazy",
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat" },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
            slash_commands = {
              ["buffer"] = {
                opts = {
                  provider = "mini_pick",
                },
              },
              ["fetch"] = {
                opts = {
                  provider = "mini_pick",
                },
              },
              ["file"] = {
                opts = {
                  provider = "mini_pick",
                },
              },
              ["help"] = {
                opts = {
                  provider = "mini_pick",
                },
              },
              ["symbols"] = {
                opts = {
                  provider = "mini_pick",
                },
              },
            },
            keymaps = {
              close = {
                modes = {
                  n = "q",
                  i = "q",
                },
              },
              stop = {
                modes = {
                  n = "<C-c>",
                },
              },
            },
          },
        },
        display = {
          diff = {
            provider = "mini_diff",
          },
        },
      })

      local map = require("user.util").map
      map({ "n", "v" }, "<leader>ap", "<cmd>CodeCompanionActions<cr>", { desc = "[A]i Actions [P]rompt" })
      map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle [A]i Chat" })
      map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Add<cr>", { desc = "[A]i add to [C]hat" })
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },

  {
    "dlants/magenta.nvim",
    enabled = true,
    lazy = false, -- you could also bind to <leader>mt
    build = "bun install --frozen-lockfile",
    keys = {
      { "<leader>aa", "<cmd>Magenta toggle<cr>", mode = { "n" }, desc = "Toggle [A]i chat" },
      { "<leader>an", "<cmd>Magenta new-thread<cr>", mode = { "n" }, desc = "[A]i [N]ew thread" },
      { "<leader>as", "<cmd>Magenta abort<cr>", mode = { "n" }, desc = " [A]i [S]top current operation" },
      { "<leader>ac", "<cmd>Magenta clear<cr>", mode = { "n" }, desc = "[A]i [C]lear state" },
      { "<leader>ae", "<cmd>Magenta start-inline-edit<cr>", mode = { "n" }, desc = "[A]i [E]dit inline" },
      { "<leader>ae", "<cmd>Magenta start-inline-edit-selection<cr>", mode = { "v" }, desc = "[A]i [E]dit inline" },
      {
        "<leader>ab",
        "<cmd>Magenta paste-selection<cr>",
        mode = { "v" },
        desc = "Add selection to [A]i [C]hat buffer",
      },
      {
        "<leader>ab",
        function()
          require("magenta.actions").add_buffer_to_context()
        end,
        mode = { "n" },
        desc = "[A]i add [B]uffer to chat",
      },
      {
        "<leader>ab",
        "<cmd>Magenta paste-selection<cr>",
        mode = { "v" },
        desc = "Add selection to [A]i [C]hat buffer",
      },
      {
        "<leader>ab",
        function()
          require("magenta.actions").add_buffer_to_context()
        end,
        mode = { "n" },
        desc = "[A]i add [B]uffer to chat",
      },
      {
        "<leader>af",
        function()
          require("magenta.actions").pick_context_files()
        end,
        mode = { "n" },
        desc = "[A]i add [F]iles to chat",
      },
      {
        "<leader>ap",
        function()
          require("magenta.actions").pick_provider()
        end,
        mode = { "n" },
        desc = "[A]i pick [P]rovider",
      },
    },
    opts = {
      default_keymaps = false,
      sidebarPosition = "right",
      sidebarKeymaps = {
        normal = {
          ["<CR>"] = ":Magenta send<CR>",
          ["q"] = ":Magenta toggle<CR>",
        },
      },
      displayKeymaps = {
        normal = {
          ["-"] = ":Magenta threads-overview<CR>",
          ["q"] = ":Magenta toggle<CR>",
        },
      },
      inlineKeymaps = {
        normal = {
          ["<CR>"] = function(target_bufnr)
            vim.cmd("Magenta submit-inline-edit " .. target_bufnr)
          end,
          ["q"] = function(target_bufnr)
            pcall(vim.api.nvim_buf_delete, target_bufnr, { force = true })
          end,
        },
        autoContext = {
          "context.md",
          "claude.md",
          "agent.md",
          "agents.md",
          ".cursor/rules",
          ".magenta/*.md",
        },
      },
    },
  },
}
