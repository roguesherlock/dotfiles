return {
  -- {
  --   "giuxtaposition/blink-cmp-copilot",
  --   enabled = false,
  -- },
  -- {
  --   "saghen/blink.cmp",
  --   dependencies = { "fang2hou/blink-copilot" },
  --   opts = {
  --     sources = {
  --       default = { "copilot" },
  --       providers = {
  --         copilot = {
  --           name = "copilot",
  --           module = "blink-copilot",
  --           score_offset = 100,
  --           async = true,
  --         },
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   enabled = false,
  -- },
  -- {
  --   "github/copilot.vim",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   event = "BufWinEnter",
  --   init = function()
  --     if vim.g.ai_cmp then
  --       vim.g.copilot_no_maps = true
  --     end
  --   end,
  --   config = function()
  --     if vim.g.ai_cmp then
  --       -- Block the normal Copilot suggestions
  --       vim.api.nvim_create_augroup("github_copilot", { clear = true })
  --       for _, event in pairs({ "FileType", "BufUnload", "BufEnter" }) do
  --         vim.api.nvim_create_autocmd({ event }, {
  --           group = "github_copilot",
  --           callback = function()
  --             vim.fn["copilot#On" .. event]()
  --           end,
  --         })
  --       end
  --     end
  --   end,
  -- },
  {
    "dlants/magenta.nvim",
    enabled = not vim.g.vscode,
    -- enabled = false,
    lazy = false, -- you could also bind to <leader>mt
    build = "npm install --frozen-lockfile",
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
      sidebar_position = "right",
    },
  },
  {
    "olimorris/codecompanion.nvim",
    -- enabled = not vim.g.vscode,
    enabled = false,
    keys = {
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "[A]i Actions [P]rompt" },
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle [A]i Chat" },
      { "<leader>ac", "<cmd>CodeCompanionChat Add<cr>", mode = { "n", "v" }, desc = "[A]i add to [C]hat" },
    },
    config = true,
    opts = {
      strategies = {
        chat = {
          adapter = "anthropic",
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
        inline = {
          adapter = "anthropic",
        },
      },
      display = {
        chat = {
          -- show_settings = true,
        },
        -- diff = {
        --   provider = "mini_diff",
        -- },
      },
    },
  },
  {
    "0xrusowsky/nvim-ctx-ingest",
    enabled = not vim.g.vscode,
    opts = {},
    keys = {
      {
        "<leader>ai",
        "<cmd>CtxIngest<cr>",
        desc = "[A]i [I]nsert Context",
      },
    },
  },
  {
    "PLAZMAMA/bunnyhop.nvim",
    enabled = false,
    lazy = false, -- This plugin does not support lazy loading for now
    -- Setting the keybinding for hopping to the predicted location.
    -- Change it to whatever suits you.
    keys = {
      {
        "<C-h>",
        function()
          require("bunnyhop").hop()
        end,
        desc = "[H]op to predicted location.",
      },
    },
    opts = {}, -- if using copilot
    -- Or
    -- opts = {adapter = "hugging_face", api_key = "HF_API_KEY", model = "Qwen/Qwen2.5-Coder-32B-Instruct"}, -- if using hugging face
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
