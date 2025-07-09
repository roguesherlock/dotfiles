return {
  -- Supermaven AI completion
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      require("supermaven-nvim").setup({ log_level = "off" })
      local map = require("config.keymaps").map
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

      local map = require("config.keymaps").map
      map({ "n", "v" }, "<leader>ap", "<cmd>CodeCompanionActions<cr>", { desc = "[A]i Actions [P]rompt" })
      map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle [A]i Chat" })
      map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Add<cr>", { desc = "[A]i add to [C]hat" })
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },
}
