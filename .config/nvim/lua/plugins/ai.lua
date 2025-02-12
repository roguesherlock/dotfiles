return {
  {
    "dlants/magenta.nvim",
    enabled = false,
    lazy = false, -- you could also bind to <leader>mt
    build = "bun install --frozen-lockfile",
    opts = {},
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- The following are optional:
      -- { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
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
